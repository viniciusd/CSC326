
import operator

from oauth2client.client import OAuth2WebServerFlow
from oauth2client.client import flow_from_clientsecrets
from googleapiclient.errors import HttpError
from googleapiclient.discovery import build

#import bottle
from bottle import route, run, template, Bottle, request, static_file, redirect, app, error,get
import httplib2
from _ast import Not
import pymongo as mongo

#client = []
#db = []
#links = []
#rank = []
client_id = '247769669257-6fnk6h0apofc39hhehbtnckrr5m0odie.apps.googleusercontent.com'
client_secret = 'wkBH2qk9pykSn2rvxwG_jYgK'
scope = ['profile', 'email']
redirect_uri = 'http://localhost:8080/redirect'
ip = '172.31.62.94'

from beaker.middleware import SessionMiddleware

session_opts = {
    'session.type': 'file',
    'session.cookie_expires': 300,
    'session.data_dir': './data',
    'session.auto': True
}

bottleapp = app()
app = SessionMiddleware(bottleapp, session_opts)


userdata = dict()
total_number_of_pages = 5
lab3 = 3
n = 1


@route('/', method=['GET','POST'])
@route('/pagenums/<pagenum>/query/<var_query>')
def hello(pagenum=1,var_query=""):
    s = request.environ.get('beaker.session')  # @UndefinedVariable
    global n
    n = pagenum
    if not request.forms.get('keywords') is None:
        var_query = request.forms.get('keywords')
        return template('index',url_results = find_count(var_query),lab_num= lab3,current_page=int(pagenum),num_of_pages=total_number_of_pages, user=s.get('user',None), words=var_query,number_of_words = len(var_query.split()),results=find_count(var_query),history=find_top_20(find_count(var_query)))
    else:
        return template('index',url_results = find_count(var_query),lab_num= lab3,current_page=int(pagenum),num_of_pages=total_number_of_pages, user=s.get('user',None), words=var_query,number_of_words = len(var_query.split()),results=find_count(var_query),history=find_top_20(find_count(var_query)))

@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='static/')

@route('/login/google', method=['GET'])
def home():
    s = request.environ.get('beaker.session')  # @UndefinedVariable
    if s.get('user',None) is None:
        flow = flow_from_clientsecrets("client_secrets.json",
                           scope='https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.email',
                           redirect_uri="http://localhost:8080/redirect")
        uri = flow.step1_get_authorize_url()
        redirect(str(uri))
    else:
        redirect(Bottle.get_url(bottleapp,'/'))
    
@route('/redirect')
def redirect_page():
    code = request.query.get('code', '')
    flow = OAuth2WebServerFlow( client_id=client_id,
                            client_secret=client_secret,
                            scope=scope,
                            redirect_uri=redirect_uri)
    credentials = flow.step2_exchange(code)
    token = credentials.id_token['sub']
    http = httplib2.Http()
    http = credentials.authorize(http)
    # Get user email
    users_service = build('oauth2', 'v2', http=http)
    user_document = users_service.userinfo().get().execute()
    user_email = user_document['email']
    s = request.environ.get('beaker.session')  # @UndefinedVariable
    s['user'] = user_document['email']  
    s.save()
    redirect(Bottle.get_url(bottleapp,'/'))

@route('/logout')
def logout():
    s = request.environ.get('beaker.session')  # @UndefinedVariable
    s['user'] = None
    s.save()
    redirect(Bottle.get_url(bottleapp,'/'))
    
@error(404)
def error404(error):
    var_query = ""
    s = request.environ.get('beaker.session')  # @UndefinedVariable
    return template('errorp', user=s.get('user',None), words=var_query,number_of_words = len(var_query.split()),results=find_count(var_query),history=find_top_20(find_count(var_query)))
    
def first_word(data):
    """data is the text string as it is"""
    return data.split()[0]    

def find_count(data):
    """data is the text string as it is"""
    #data_sorted = []
    #d = dict()
    #for w in data.split():
    #    found = False
    #    for y in d:
    #        if w==y:
    #            found = True
    #            d[w]+=1
    #    if not found:
    #        d[w] = 1
    #        
    d = {}
    global rank
    for info in rank.find():
    	d[info['page']] = info['rank']
    if d != []:
        data_sorted = sorted(d.items(), key=operator.itemgetter(1), reverse =True)
    """return sorted(d, key=d.get, reverse=True)"""
    r = {}
    for i, k in zip(range(len(data_sorted)), data_sorted):
        if 10*n <i < 10*(n+1):
		r[k] = data_sorted[i][1]
    return r

def find_top_20(data):
    s = request.environ.get('beaker.session')  # @UndefinedVariable
    if not s.get('user',None) is None:
        user = s.get('user')
        history = userdata.get(user)
        if history is None:
            history = dict()
            userdata[user] = history
        """print data"""
        """return a sorted dictionary with 20 entries"""
       
        for item in data:
            found = False
            for key1 in history:
                if key1==item[0]:
                    found = True
                    history[key1]+=item[1]
            if not found:
                history[item[0]] = item[1]

        data_sorted = sorted(history.items(), key=operator.itemgetter(1), reverse =True)

        if(data_sorted != []):
            return data_sorted[:20]
        
        return data_sorted
    else:
        return None

if __name__ == '__main__':
	global client
	global db
	global links
	global rank
	client = mongo.MongoClient('mongodb://CSC326:programminglanguages@ds043200.mongolab.com:43200/searchengine')
	db = client['searchengine']
	#lexicon = self.db['lexicon']
	#documents = self.db['documents']
	links = db['links']
	rank = db['rank']	
	#run(app=app, reloader =True)
	run(app=app, host=ip, port=80, reloader=True)

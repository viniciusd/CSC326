<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Programming Languages - Lab2</title>

<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.5.0/pure-min.css">

    <!-- Bootstrap Core CSS -->
    <link href="/static/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/static/css/landing-page.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">


</head>

<body>

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
                % if user != None:
                <a class="navbar-brand">{{user}}</a>
                % end
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <!-- div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"-->
                <ul class="nav navbar-nav navbar-right">
                % if user is None:			
                <form action="/login/google" class="pure-form">
   				 	<fieldset>
                       <button type="submit" class="pure-button pure-button-primary">Sign in</button>
                    </fieldset>
				</form>
				% else:
                <form action="/logout" class="pure-form">
   				 	<fieldset>
                       <button type="submit" class="pure-button pure-button-primary">Sign Out</button>
                    </fieldset>
				</form>
				%end
                </ul>
            <!--/div-->
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Header -->
    <div class="intro-header">

        <div class="container">

            <div class="row">
                <div class="col-lg-12">
                    <div class="intro-message">
                        <h1>Programming Languages</h1>
                        <h3>Lab 2</h3>
                        <hr class="intro-divider">
                        
						<h5>Insert your string in the text box</h5>
                        <form action="/" method="POST">
                        <ul class="pure-form">
                       		<input type="text" class="pure-input-rounded" style="color:grey" name="keywords">
  						  	<button type="submit" class="pure-button" value="Submit">Search</button>
                            
                        </ul>
                        </form>
                        % if words!="":
                        <h6 class="subtitle">Search for: "{{words}}"</h6>
						<h6 class="subtitle">Word Count: {{number_of_words}}</h6>
						<br>	
						<br>	
						<br>	
						<br>
						% if user == None:
						<h4 class="subtitle">You can check the results table below</h4>	
						
						% else:
						<h4 class="subtitle">You can check the results table and your history table below</h4>
						% end
						<img src="http://www.iconsdb.com/icons/download/white/arrow-199-512.gif" height="50" width="50"></img>
						% end
                    </div>
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.intro-header -->

    <!-- Page Content -->
   % if results!=[]: 
    <div class="content-section-a">

        <div class="container">

            <div class="row">
                <div class="col-lg-5 col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading">Results Table</h2>
                    <p class="lead"></p>
                </div>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
             
                   <table id=”results”  class="pure-table">
    <thead>
        <tr>
            <th>Keyword</th>
			<th>Frequency</th>
        </tr>
    </thead>

    <tbody>
         % for item in results:
			<tr class="pure-table-odd">
				<th>{{ item[0] }}</th>
				<td>{{ item[1] }}</td>
			</tr>
			% end 
			
    </tbody>
</table>
 
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    % end
    <!-- /.content-section-a -->
  % if history!=None and history!=[] and words!="":    
     <div class="content-section-b">

        <div class="container">

            <div class="row">
                <div class="col-lg-5 col-lg-offset-1 col-sm-push-6  col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading">History Table</h2>
                    <p class="lead"></p>
                </div>
                <div class="col-lg-5 col-sm-pull-6  col-sm-6">
           
                   <table id=”history”  class="pure-table">
    <thead>
        <tr>
            <th>Keyword</th>
			<th>Frequency</th>
        </tr>
    </thead>

    <tbody>
  
         % for item in history:
			<tr class="pure-table-odd">
				<th>{{ item[0] }}</th>
				<td>{{ item[1] }}</td>
			</tr>
			% end
		
    </tbody>
</table>
 
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    % end
    <!-- /.content-section-b -->


    
    <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>

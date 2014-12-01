#!/usr/bin/python
# Copyright (C) 2011 by Peter Goodman
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

import redis
import MySQLdb as mysql

def page_rank(links, num_iterations=20, initial_pr=1.0):
    from collections import defaultdict
    import numpy as np

    page_rank = defaultdict(lambda: float(initial_pr))
    num_outgoing_links = defaultdict(float)
    incoming_link_sets = defaultdict(set)
    incoming_links = defaultdict(lambda: np.array([]))
    damping_factor = 0.85

    # collect the number of outbound links and the set of all incoming documents
    # for every document
    for (from_id,to_id) in links:
        num_outgoing_links[from_id] += 1.0
        incoming_link_sets[to_id].add(from_id)
    
    # convert each set of incoming links into a numpy array
    for doc_id in incoming_link_sets:
        incoming_links[doc_id] = np.array([from_doc_id for from_doc_id in incoming_link_sets[doc_id]])

    num_documents = float(len(num_outgoing_links))
    lead = (1.0 - damping_factor) / num_documents
    partial_PR = np.vectorize(lambda doc_id: page_rank[doc_id] / num_outgoing_links[doc_id])

    for _ in xrange(num_iterations):
        for doc_id in num_outgoing_links:
            tail = 0.0
            if len(incoming_links[doc_id]):
                tail = damping_factor * partial_PR(incoming_links[doc_id]).sum()
            page_rank[doc_id] = lead + tail
    print page_rank
    return page_rank

if __name__ == "__main__":
	r = redis.StrictRedis(host='104.131.174.43', port=6379, db=0)

	db=mysql.connect(host='127.0.0.1', user="root",passwd="programminglanguages",db="CSC326")
	c = db.cursor()
	c.execute("TRUNCATE `rank`")
	l = []
	c.execute("SELECT `from`, `to` FROM `links`")
	for conn in c.fetchone():
		l.append(conn)
	for (id, v) in page_rank(l).viewitems():
		print('Inserting {0}...'.format((id)))
		c.execute("INSERT INTO `rank` (`page`, `rank`) VALUES (%s, %s)", (id, v))
		r.set("page:"+str(id), v)

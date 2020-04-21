#!/usr/bin/python3
#
from flask import Flask, request, abort, Response, jsonify as flask_jsonify, make_response
import argparse 
import sys, os, getopt, socket, json, time

app = Flask(__name__)

start_time = time.time()

@app.route('/')
def index():
        return ('ClientIP: {}, ServerName: {}, ''ServerIP: {}!\n'.format(request.remote_addr, socket.gethostname(),
                                                                socket.gethostbyname(socket.gethostname())))

def main(argv):
    port = 80
    host = '0.0.0.0'
    debug = False

    if os.environ.get('PORT') is not None:
        port = os.environ.get('PORT')

    if os.environ.get('HOST') is not None:
        host = os.environ.get('HOST')

    try:
        opts, args = getopt.getopt(argv,"vh:p:",["verbose","host=","port="])
    except getopt.GetoptError:
        print('server.py -p <portnumber>')
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-p", "--port"):
            port = arg
        elif opt in ("-h", "--host"):
            host = arg
        elif opt in ("-v", "--verbose"):
            debug = True

    app.run(host=str(host), port=int(port), debug=bool(debug))


if __name__ == "__main__":
    main(sys.argv[1:])

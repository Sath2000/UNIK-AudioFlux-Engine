#!/usr/bin/env python3
"""Simple HTTP server for UNIK AudioFlux Engine"""

import http.server
import socketserver
import os
from pathlib import Path

PORT = 3000
HOST = '127.0.0.1'

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    """Custom request handler with proper MIME types"""

    def end_headers(self):
        # Add CORS headers for WASM files
        if self.path.endswith('.wasm'):
            self.send_header('Access-Control-Allow-Origin', '*')
        super().end_headers()

    def do_GET(self):
        # Serve index.html for root path
        if self.path == '/':
            self.path = '/index.html'
        return super().do_GET()

if __name__ == '__main__':
    # Change to project directory
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    
    print('\n' + '='*60)
    print('UNIK AudioFlux Engine Server Started')
    print('='*60)
    print(f'Server: http://{HOST}:{PORT}')
    print(f'Open your browser and navigate to: http://localhost:{PORT}')
    print('='*60 + '\n')
    
    try:
        with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
            print(f'Server running on port {PORT}...')
            print('Press Ctrl+C to stop the server\n')
            httpd.serve_forever()
    except OSError as e:
        if e.errno == 48 or e.errno == 98:  # Address already in use
            print(f'ERROR: Port {PORT} is already in use.')
            print('Please close the other process or use a different port.')
        else:
            print(f'ERROR: {e}')
        exit(1)
    except KeyboardInterrupt:
        print('\n\nServer stopped.')
        exit(0)

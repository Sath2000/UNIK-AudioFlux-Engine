#!/usr/bin/env python3
"""Simple HTTP server for UNIK AudioFlux Engine"""

import http.server
import socketserver
import os
from pathlib import Path

PORT = 3000
HOST = '127.0.0.1'

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    """Custom request handler with proper MIME types and visitor counting"""

    # load or initialize visitor count
    count_file = Path(__file__).parent / 'visitorCount.json'
    try:
        visitor_count = int(count_file.read_text())
    except Exception:
        visitor_count = 0

    def end_headers(self):
        # Add CORS and Cross-Origin Isolation headers for FFmpeg
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        self.send_header('Cross-Origin-Embedder-Policy', 'require-corp')
        self.send_header('Access-Control-Allow-Origin', '*')
        super().end_headers()

    def do_GET(self):
        # API endpoint for visitor count
        if self.path == '/visitor-count':
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Cache-Control', 'no-cache')
            self.end_headers()
            self.wfile.write(f'{{"count": {self.visitor_count}}}'.encode())
            return

        # Serve index.html for root path and increment counter
        if self.path == '/':
            self.path = '/index.html'
            # increment and save
            self.__class__.visitor_count += 1
            try:
                self.count_file.write_text(str(self.visitor_count))
            except Exception:
                pass

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

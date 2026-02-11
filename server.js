// Simple HTTP server for UNIK AudioFlux Engine
// Run with: node server.js

const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

const PORT = 3000;
const HOST = 'localhost';

// MIME types mapping
const mimeTypes = {
    '.html': 'text/html',
    '.js': 'application/javascript',
    '.css': 'text/css',
    '.json': 'application/json',
    '.wasm': 'application/wasm',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.gif': 'image/gif',
    '.svg': 'image/svg+xml',
    '.txt': 'text/plain',
    '.mp4': 'video/mp4',
    '.wav': 'audio/wav',
    '.mp3': 'audio/mpeg',
};

// Create server
const server = http.createServer((req, res) => {
    // Parse request URL
    const parsedUrl = url.parse(req.url, true);
    let pathname = parsedUrl.pathname;

    // Default to index.html
    if (pathname === '/') {
        pathname = '/index.html';
    }

    // Resolve file path
    let filePath = path.join(__dirname, pathname);

    // Security: prevent directory traversal
    const realPath = path.resolve(filePath);
    const basePath = path.resolve(__dirname);
    if (!realPath.startsWith(basePath)) {
        res.writeHead(403, { 'Content-Type': 'text/plain' });
        res.end('Forbidden');
        return;
    }

    // Read and serve file
    fs.readFile(filePath, (err, content) => {
        if (err) {
            if (err.code === 'ENOENT') {
                res.writeHead(404, { 'Content-Type': 'text/plain' });
                res.end('404 Not Found');
            } else {
                res.writeHead(500, { 'Content-Type': 'text/plain' });
                res.end('500 Server Error');
            }
        } else {
            // Get MIME type
            const ext = path.extname(filePath).toLowerCase();
            const mimeType = mimeTypes[ext] || 'application/octet-stream';

            // Set headers for WASM files
            if (ext === '.wasm') {
                res.writeHead(200, {
                    'Content-Type': mimeType,
                    'Access-Control-Allow-Origin': '*',
                });
            } else {
                res.writeHead(200, { 'Content-Type': mimeType });
            }

            res.end(content);
        }
    });
});

// Start server
server.listen(PORT, HOST, () => {
    console.log(`\n${'='.repeat(60)}`);
    console.log('UNIK AudioFlux Engine Server Started');
    console.log(`${'='.repeat(60)}`);
    console.log(`Server: http://${HOST}:${PORT}`);
    console.log(`Open your browser and navigate to: http://localhost:${PORT}`);
    console.log(`${'='.repeat(60)}\n`);
});

server.on('error', (err) => {
    if (err.code === 'EADDRINUSE') {
        console.error(`Port ${PORT} is already in use. Please try a different port.`);
    } else {
        console.error(`Server error: ${err.message}`);
    }
    process.exit(1);
});

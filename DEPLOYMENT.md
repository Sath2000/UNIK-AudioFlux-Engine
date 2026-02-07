# 🚀 Deployment & Installation Guide

## Quick Start (Choose One)

### Option 1: Direct Use (Easiest)
```bash
1. Open index.html directly in your browser
2. That's it! No installation needed.
```

### Option 2: Local Server

#### Windows
```batch
# Using Python (if installed)
python -m http.server 8000

# Or using Node.js
npx http-server
```

#### macOS/Linux
```bash
# Using Python
python3 -m http.server 8000

# Or using Node.js
npx http-server

# Or using Ruby
ruby -run -ehttpd . -p8000
```

Then open: **http://localhost:8000**

---

## Deployment Options

### 1. **Personal Use (No Server)**
✅ Best for: Personal conversion needs

```bash
1. Save index.html anywhere on your computer
2. Double-click to open in browser
3. Use offline (after initial load)
```

**Pros:**
- No setup required
- 100% offline after load
- Works on any device
- No data transmission

---

### 2. **Share via File Sharing**
✅ Best for: Sharing with a few people

```bash
1. Send index.html to friends via:
   - Email
   - Google Drive
   - Dropbox
   - OneDrive
   - USB drive

2. They open it directly in their browser
```

**Pros:**
- Simple to share
- Works offline
- No installation

**Cons:**
- Browser security warnings may appear

---

### 3. **Self-Hosted Server**
✅ Best for: Personal website/intranet

```
Requirements:
- Domain or subdomain
- Web hosting (cheap option: $2-5/month)
- SFTP or web control panel access

Steps:
1. Upload index.html to your server
2. Visit domain.com/converter
3. That's it!
```

**Hosting Options:**
- Bluehost: $2.95/month
- GoDaddy: $2.99/month
- DigitalOcean: $4/month
- Linode: $5/month
- AWS Free Tier: Free (first year)

---

### 4. **Free Hosting Services**

#### GitHub Pages (Free)
```bash
# Setup
1. Create GitHub account
2. Create new repository: username.github.io
3. Upload index.html
4. Visit: username.github.io/video-to-audio

# Or use GitHub Pages directly
1. New repo: video-to-audio
2. Enable GitHub Pages in settings
3. Visit: username.github.io/video-to-audio
```

#### Netlify (Free)
```bash
# Setup
1. Drag & drop index.html to netlify.com
2. Get automatic HTTPS URL
3. Share the link

Benefits:
- Free custom domain
- Automatic HTTPS
- One-click setup
```

#### Vercel (Free)
```bash
# Setup
1. Upload to Vercel
2. Automatic deployment
3. Custom domain available
```

---

### 5. **Docker Container**
✅ Best for: Containerized deployment

#### Dockerfile
```dockerfile
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/
COPY README.md /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

#### Build & Run
```bash
# Build
docker build -t everyvideoconverter .

# Run
docker run -p 80:80 everyvideoconverter

# Or using Docker Compose
docker-compose up
```

---

### 6. **Electron Desktop App**
✅ Best for: Desktop application distribution

#### main.js
```javascript
const { app, BrowserWindow } = require('electron');
const path = require('path');

let mainWindow;

app.on('ready', () => {
    mainWindow = new BrowserWindow({
        webPreferences: {
            nodeIntegration: false
        }
    });
    
    mainWindow.loadFile('index.html');
    mainWindow.webContents.openDevTools(); // Remove for production
});
```

#### package.json
```json
{
    "name": "EveryVideo",
    "version": "1.0.0",
    "main": "main.js",
    "scripts": {
        "start": "electron ."
    },
    "devDependencies": {
        "electron": "^latest"
    }
}
```

---

## Browser Extension Version

### Manifest.json
```json
{
    "manifest_version": 3,
    "name": "EveryVideo Converter",
    "version": "1.0",
    "description": "Extract audio from videos locally",
    "permissions": ["scripting"],
    "action": {
        "default_popup": "index.html",
        "default_title": "EveryVideo"
    }
}
```

---

## Server Configuration Examples

### Apache (.htaccess)
```apache
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /video-to-audio/
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule . index.html [L]
</IfModule>

<FilesMatch "\.(js|css|jpg|jpeg|png|gif|ico|svg)$">
    Header set Cache-Control "max-age=31536000, public"
</FilesMatch>
```

### Nginx (nginx.conf)
```nginx
server {
    listen 80;
    server_name converter.example.com;
    
    root /var/www/converter;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires 365d;
        add_header Cache-Control "public, immutable";
    }
}
```

---

## Performance & Optimization

### Content Delivery Network (CDN)
FFmpeg.wasm is already served via CDN (jsDelivr), so:
- ✅ Global distribution
- ✅ Automatic caching
- ✅ Fast downloads

### Browser Caching
Add to server headers:
```
Cache-Control: public, max-age=31536000
```

### Compression
Nginx auto-compression:
```nginx
gzip on;
gzip_types text/plain text/css application/javascript;
```

---

## HTTPS/SSL Setup

### Important
- Modern browsers require HTTPS for WebAssembly
- Free SSL: Let's Encrypt

### Get Free SSL
```bash
# Using Certbot
certbot certonly --standalone -d converter.example.com

# Then configure in Nginx
ssl_certificate /etc/letsencrypt/live/converter.example.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/converter.example.com/privatekey.pem;
```

---

## Monitoring & Analytics

### Server Status Monitoring
```bash
# Uptime monitoring service
# - UptimeRobot (free)
# - StatusPage.io
# - Pingdom
```

### Usage Analytics (Optional)
Add minimal tracking (without sending data):
```javascript
// Example: Track button clicks locally
console.log('User clicked convert');
```

---

## Troubleshooting Deployment

### FFmpeg Not Loading
**Problem**: "Failed to load FFmpeg"
```
Solution:
1. Check internet connection (needed for WASM download)
2. Verify CDN URLs are accessible
3. Check browser console for errors
```

### CORS Issues
**Problem**: "CORS policy blocked"
```
Solution:
1. Use HTTPS (some browsers require it)
2. Check browser console for specific CORS error
3. FFmpeg.wasm should load from CDN without CORS issues
```

### White Screen/Blank Page
**Problem**: Nothing loads
```
Solution:
1. Check browser console (F12)
2. Verify index.html is in correct location
3. Try different browser
4. Clear browser cache
```

---

## Environment Variables

No environment variables needed! The app is completely self-contained.

### Optional Customization
Add a config object (for future use):
```javascript
const config = {
    defaultFormat: 'mp3',
    maxFileSize: 4000, // MB
    defaultBitrate: 192,
    enableAnalytics: false,
};
```

---

## Backup & Recovery

### Backup Steps
```bash
1. Backup index.html
2. Backup README.md and documentation
3. Version control with Git:
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/user/repo
   git push -u origin main
```

### Recovery
```bash
# Restore from Git
git clone https://github.com/user/video-to-audio
cd video-to-audio
# Open index.html in browser
```

---

## Scaling Considerations

### For Heavy Load
FFmpeg.wasm processes on client side, so:
- ✅ No server load
- ✅ Scalable to unlimited users
- ✅ No bandwidth cost
- ✅ No processing cost

### Bandwidth
Only used for:
1. Initial HTML file (~50KB)
2. FFmpeg WASM (~30MB, cached)
3. User downloads (audio files)

**Monthly Cost at Scale**: ~$5-10 (just the hosting)

---

## Version Updates

### Check for Updates
FFmpeg.wasm is automatically fetched from CDN, so:
- ✅ Always latest version
- ✅ Automatic updates
- ✅ No manual intervention

### Update the App
1. GitHub releases: New version in README
2. Manual update: Re-upload index.html

---

## Support & Contact

### For Issues
1. Check browser console (F12)
2. Clear browser cache
3. Try different browser
4. Check documentation

### For Feature Requests
Document clearly with:
- Use case
- Expected behavior
- Current behavior

---

**Choose your deployment method and get started! 🚀**

Happy converting! 🎵

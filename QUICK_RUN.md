# UNIK AudioFlux Engine - Quick Start Guide

## Project Setup Complete! ✓

Your FFmpeg.wasm files have been successfully installed:
- ✓ ffmpeg.min.js (23 KB)
- ✓ ffmpeg-core.js (100 KB) 
- ✓ ffmpeg-core.wasm (23.23 MB)

## Running the Application

Since this is a web application, you need to run it through a local web server (browsers don't allow direct file:// access for security reasons).

### Option 1: Using Node.js (Recommended)

1. If you have Node.js installed, run:
```bash
cd "D:\softwares\sw 1\video_to_audio"
node server.js
```

2. Open your browser and go to: **http://localhost:3000**

### Option 2: Using Python

If you have Python installed (Python 3.x):

```bash
cd "D:\softwares\sw 1\video_to_audio"
python server.py
```

Open your browser and go to: **http://localhost:3000**

### Option 3: Using Windows Built-in HTTP Server

Open PowerShell in the project directory and run:
```powershell
python -m http.server 3000
```

## What to Expect

1. Homepage loads - you'll see "UNIK AudioFlux Engine" title
2. FFmpeg Status badge will show: "⏳ Loading FFmpeg..."
3. After ~10-30 seconds, it will change to: "✅ Ready to use"
4. Upload a video file (MP4, MKV, AVI, MOV, etc.)
5. Select your desired audio format (MP3, WAV, AAC, FLAC, OGG, M4A)
6. Click "Extract & Convert" button
7. Download your audio file when ready

## System Requirements

- Modern web browser (Chrome, Firefox, Edge, Safari)
- Stable internet connection (for initial FFmpeg setup)
- At least 1GB RAM for processing
- For videos >4GB, processing may be slow or time out

## Troubleshooting

### FFmpeg shows "❌ FFmpeg Failed"
- Refresh the page and wait for FFmpeg to load
- Check browser console for error messages (F12 → Console tab)
- Ensure all three FFmpeg files are in the ffmpeg/ folder

### Conversion fails or is very slow
- Try with a smaller video file first
- Check your available system RAM
- Large files (>2GB) may timeout - consider splitting them

### Port 3000 already in use
Change the port when starting:
```bash
node server.js --port 3001
# or
python server.py 3001
```

## Features

✓ 100% offline processing (after initial load)
✓ No file uploads to servers
✓ Supports 6 audio formats
✓ Adjustable bitrate, sample rate, and channels
✓ Real-time progress display
✓ Service Worker for offline caching support

## Direct FFmpeg Path Note

Your native FFmpeg at `D:\ffmpeg\ffmpeg` is separate from this web application. 
The web app uses FFmpeg.wasm (compiled to WebAssembly) for browser-based processing.
If you want to use your native FFmpeg for command-line tools, you can do so separately.

## Questions?

For more information, see:
- README.md - Project overview
- TECHNICAL.md - Technical architecture
- TROUBLESHOOTING.md - Detailed troubleshooting guide

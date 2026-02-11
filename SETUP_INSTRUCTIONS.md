# UNIK AudioFlux Engine - Installation & Setup Guide

## ✓ Current Status

Successfully completed:
- [x] Downloaded FFmpeg.wasm files (23.23 MB)
- [x] Configured application structure
- [x] Ready for deployment

## ⚠️ What You Need to Do

Your application is **almost ready**! You just need to install a web server to run it. Here are your options:

---

## Option 1: Install Node.js (Recommended - Easiest)

Node.js comes with npm and is the easiest way to run the server.

### Windows Steps:
1. Download from: https://nodejs.org/ (Get the LTS version)
2. Run the installer and follow the prompts
3. Click "START_SERVER.bat" in the project folder, OR run:
   ```powershell
   cd "D:\softwares\sw 1\video_to_audio"
   node server.js
   ```
4. Open browser to: **http://localhost:3000**

### Verify Installation:
```powershell
node --version
npm --version
```

---

## Option 2: Install Python (Alternative)

Python is also a good option and already installed on many systems.

### Windows Steps:
1. Download from: https://www.python.org/downloads/
2. Run the installer
3. **IMPORTANT**: Check "Add Python to PATH" during installation
4. Click "START_SERVER.bat" in the project folder, OR run:
   ```powershell
   cd "D:\softwares\sw 1\video_to_audio"
   python server.py
   ```
5. Open browser to: **http://localhost:3000**

### Verify Installation:
```powershell
python --version
```

---

## Option 3: Use Windows 10/11 Built-in App Installer

If you have Windows 10/11, you can use the Microsoft Store:

1. Search for "Python 3.x" in Microsoft Store
2. Click Install
3. Then run:
   ```powershell
   cd "D:\softwares\sw 1\video_to_audio"
   python server.py
   ```

---

## Once You Have a Server Running

1. **Click START_SERVER.bat** - a browser window should open
   - OR go to: http://localhost:3000

2. **Wait for FFmpeg to Load** (first time takes 10-30 seconds)
   - You'll see: "⏳ Loading FFmpeg..."
   - Then: "✅ Ready to use"

3. **Upload a video file**
   - Drag & drop or click to browse
   - Supports: MP4, MKV, AVI, MOV, WebM, and many more

4. **Select audio format**: MP3, WAV, AAC, FLAC, OGG, or M4A

5. **Adjust settings** (optional)
   - Bitrate: 128-320 kbps
   - Sample rate: 44.1kHz to 96kHz
   - Channels: Mono or Stereo

6. **Click "Extract & Convert"**
   - Progress bar shows conversion status
   - Processing happens entirely on your computer

7. **Download your audio file**
   - Click "📥 Download Audio"
   - File saved to your Downloads folder

---

## Troubleshooting

### "FFmpeg Failed" Error
- **Solution**: Refresh the page and wait 30 seconds
- Check that all files are in: `D:\softwares\sw 1\video_to_audio\ffmpeg\`
  - ffmpeg.min.js
  - ffmpeg-core.js
  - ffmpeg-core.wasm

### Port 3000 Already in Use
- **Solution**: Kill other processes using that port
  ```powershell
  Get-Process | Where-Object {$_.Name -like "*node*" -or $_.Name -like "*python*"} | Stop-Process -Force
  ```
- OR edit server.js/server.py to use port 3001

### File Upload Issues
- Make sure browser allows local file access
- Try a different browser (Chrome, Firefox, Edge)
- Clear browser cache (Ctrl+Shift+Delete)

### Video Won't Convert
- Try a smaller test file first
- Check available disk space
- Large files (>2GB) may timeout
- Check browser console for errors (F12 → Console tab)

### "Cannot find command python/node"
- Make sure to add to PATH during installation
- Restart PowerShell/terminal after installing
- Use full path: `C:\Python312\python.exe server.py`

---

## Project Files Reference

```
D:\softwares\sw 1\video_to_audio\
├── index.html              (Main app interface)
├── styles.css              (Styling)
├── server.js               (Node.js server)
├── server.py               (Python server)
├── START_SERVER.bat        (Windows quick start)
├── sw.js                   (Service Worker - offline support)
├── ffmpeg/
│   ├── ffmpeg.min.js       (FFmpeg JavaScript wrapper)
│   ├── ffmpeg-core.js      (FFmpeg loader)
│   └── ffmpeg-core.wasm    (FFmpeg WebAssembly binary)
└── [documentation files]
```

---

## What FFmpeg.wasm Does

FFmpeg.wasm is FFmpeg compiled to WebAssembly (runs in browser):
- ✅ No installation needed (it's bundled)
- ✅ Runs entirely in your browser
- ✅ Never uploads files to servers
- ✅ Works offline after initial load
- ✅ Process entire videos in memory

Your local FFmpeg (`D:\ffmpeg\ffmpeg`) is **separate** - this app uses the browser version.

---

## Performance Tips

1. **For best results**: 
   - Use MP4 or WebM video format
   - File size < 2GB
   - Use Medium bitrate (192 kbps) initially
   - Close other applications

2. **For large files**:
   - Convert in segments first
   - Use lower sample rate (44.1 kHz)
   - Use lower bitrate (128 kbps)
   - Use Mono instead of Stereo

3. **Browser tips**:
   - Use latest Chrome/Firefox for best performance
   - Allocate more RAM to browser
   - Use hardware acceleration (if available)

---

## Getting Help

If you encounter issues:

1. Check **TROUBLESHOOTING.md** in the project root
2. Review browser console logs (F12 → Console)
3. Check server logs in the terminal
4. Try the demo with a simple small MP4 file first

---

## Next Steps

1. Install Node.js OR Python
2. Double-click **START_SERVER.bat**
3. Wait for browser to open at http://localhost:3000
4. Follow the on-screen instructions!

Happy converting! 🎵

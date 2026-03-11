# 🎵 EveryVideo Audio Extractor & Converter

A fully functional, **browser-based** audio extraction and conversion tool that works **100% offline** on your device. Extract audio from any video file and convert it to multiple formats without uploading anything to the cloud.

---

## ✨ Features

### Core Functionality
- ✅ **Extract audio** from any video format (MP4, MKV, AVI, MOV, FLV, WMV, WebM, etc.)
- ✅ **Convert to 6 popular formats**: MP3, WAV, AAC, FLAC, OGG, M4A
- ✅ **100% Client-Side Processing**: Zero data leaves your device
- ✅ **Offline-First**: Works completely offline after initial load
- ✅ **Fast & Accurate**: FFmpeg-powered conversion with high precision
- ✅ **No Installation Required**: Just open the HTML file in a browser

### Quality Control
- 🎛️ **Adjustable Bitrate**: 128 kbps, 192 kbps, 256 kbps, 320 kbps
- 🎯 **Sample Rate Selection**: 44.1 kHz, 48 kHz, 96 kHz
- 🔊 **Channel Options**: Mono or Stereo
- 📊 **Real-time Progress Tracking**: Visual progress bar

### User Experience
- 🎨 **Modern, Responsive UI**: Works on desktop and mobile
- 📱 **Drag & Drop Support**: Drag videos directly onto the upload zone
- ⌨️ **Keyboard Friendly**: Accessible interface
- 🔐 **Privacy-Focused**: No tracking, no data collection
- ⚡ **Instant Feedback**: Real-time status messages
- 📥 **One-Click Download**: Instant access to converted audio

---

## 🚀 How to Use

> **Visitor Counter**
> The live visitor count is shown in the footer when running via the supplied Node server (`server.js`). It increments each time the homepage is requested and is persisted across restarts.


### Quick Start
1. **Open** `index.html` in any modern web browser (Chrome, Firefox, Safari, Edge)
2. **Wait** for FFmpeg to load (you'll see "✅ Ready to use" badge)
3. **Upload** a video file (click or drag-and-drop)
4. **Select** your desired output format
5. **Click** "Extract & Convert"
6. **Download** your audio when ready

### Step-by-Step Guide

#### Step 1: Upload Video
- Click the upload zone or drag a video file onto it
- Supported video formats: MP4, MKV, AVI, MOV, FLV, WMV, WebM, and more
- File size can be up to your browser's memory capacity (typically 1-4GB)

#### Step 2: Choose Output Format
Select from these audio formats:
- **MP3** (Best for portable devices) - Default option
- **WAV** (Lossless, uncompressed)
- **AAC** (Modern compression)
- **FLAC** (Lossless compression)
- **OGG** (Open format, webm-friendly)
- **M4A** (iTunes compatible)

#### Step 3: Configure Advanced Options (Optional)
Click "⚙️ Advanced Options" to customize:
- **Bitrate**: Quality vs file size tradeoff
  - 128 kbps: Smallest file, acceptable quality
  - 192 kbps: Balanced (recommended)
  - 256 kbps: High quality
  - 320 kbps: Maximum quality
  
- **Sample Rate**: Frequency quality
  - 44.1 kHz: CD quality (most compatible)
  - 48 kHz: Professional/broadcast
  - 96 kHz: High-resolution audio
  
- **Channels**: Audio channels
  - Stereo (2): Full audio channels
  - Mono (1): Space-saving option

#### Step 4: Extract & Convert
- Click the "Extract & Convert" button
- Watch the progress bar as the conversion progresses
- The process runs entirely on your computer

#### Step 5: Download
- Once complete, your audio file appears in the download section
- Click "📥 Download Audio" to save it
- Or click "Convert Another" to process more videos

---

## 🔧 Technical Details

### Technology Stack
- **Frontend**: HTML5, CSS3, Vanilla JavaScript (ES6+)
- **Audio Processing**: FFmpeg.wasm (WebAssembly)
- **Architecture**: Client-side only, no backend required

### How It Works
1. FFmpeg.wasm (compiled to WebAssembly) runs in your browser
2. Your video file is processed locally
3. Audio is extracted and transcoded to your chosen format
4. The result is saved to your downloads folder
5. No data is transmitted or stored anywhere else

### Browser Compatibility
- ✅ Chrome/Chromium 60+
- ✅ Firefox 55+
- ✅ Safari 12+
- ✅ Edge 79+
- ✅ Mobile browsers (Chrome Mobile, Firefox Mobile, Safari iOS)

### File Size Handling
- Input files up to **2-4GB** (limited by browser memory)
- Typical processing time:
  - 100MB video: ~1-2 minutes
  - 500MB video: ~5-10 minutes
  - 1GB video: ~10-20 minutes

---

## 🎯 Format Recommendations

### Best for Portability
**→ MP3** - Universal support, compressed

### Best for Quality
**→ FLAC** - Lossless compression, larger files
**→ WAV** - Uncompressed, highest quality

### Best for Streaming
**→ AAC** - Modern compression, good quality
**→ M4A** - iTunes/Apple ecosystem

### Best for Open Standards
**→ OGG** - Open source, web-friendly

---

## 🔒 Privacy & Security

- ✅ **No uploads**: Videos never leave your computer
- ✅ **No tracking**: No analytics or telemetry
- ✅ **No accounts**: No sign-ups or logins required
- ✅ **No servers**: Completely peer-to-peer
- ✅ **Open source ready**: Code is transparently available
- ✅ **Data retention**: Nothing is stored after conversion

---

## ⚡ Performance Tips

### For Faster Conversion
1. Use **lower bitrate** (128-192 kbps) for faster processing
2. Choose **44.1 kHz sample rate** (standard CD quality)
3. Select **Stereo** (mono saves processing time)
4. Use newer browsers (Chrome/Edge are typically faster)

### For Best Quality
1. Use **320 kbps bitrate** for MP3
2. Use **FLAC** or **WAV** for lossless audio
3. Use **96 kHz sample rate** for high-resolution
4. Keep **Stereo** for full frequency spectrum

---

## 🆘 Troubleshooting

### FFmpeg Not Loading
- **Solution**: Refresh the page and wait 10 seconds
- Check your internet connection (needed for initial FFmpeg download)
- Try a different browser

### Conversion Failed
- **Cause**: Unsupported video codec
- **Solution**: Try converting with a different tool first, or try different output format

### Audio Quality Issues
- **Cause**: Low bitrate selected
- **Solution**: Increase bitrate in Advanced Options to 256-320 kbps

### Large File Processing Slowly
- **Cause**: Browser memory limitations
- **Solution**: Close other tabs/apps to free memory, or split video into smaller parts

### Download Not Starting
- **Cause**: Browser block on downloads
- **Solution**: Check browser download settings and allow downloads

---

## 📊 Supported Formats

### Input Video Formats
MP4, WebM, MKV, AVI, MOV, FLV, WMV, MPG, MPEG, 3GP, M4V, MTS, M2TS, TS, VOB, and more

### Output Audio Formats
| Format | Quality | Size | Compatibility |
|--------|---------|------|----------------|
| MP3 | Good | Small | Universal ✅ |
| WAV | Lossless | Large | All systems ✅ |
| AAC | Good | Small | Modern systems ✅ |
| FLAC | Lossless | Medium | Music apps ✅ |
| OGG | Good | Small | Web browsers ✅ |
| M4A | Good | Small | Apple devices ✅ |

---

## 🎓 Advanced Usage

### Batch Processing Tips
1. Process videos one at a time
2. Use "Convert Another" button for quick succession
3. Organize outputs by format in your file system

### Professional Audio Extraction
1. Use **WAV or FLAC** for editing in audio software
2. Use **96 kHz sample rate** for professional work
3. Use **320 kbps** for maximum fidelity

### Storage Optimization
1. Use **MP3 at 192 kbps** for general listening
2. Use **FLAC** only if you need lossless quality
3. Archive conversions to external drive

---

## 🌟 Why EveryVideo?

### vs. Online Converters
- ✅ No uploads (privacy)
- ✅ Works offline
- ✅ Faster (no server latency)
- ✅ Free forever

### vs. Desktop Software
- ✅ No installation
- ✅ Works on any device
- ✅ Updated automatically
- ✅ Lighter footprint

### vs. Video Hosting Platforms
- ✅ Extract ANY video locally
- ✅ No DRM restrictions
- ✅ Batch process easily
- ✅ Complete control

---

## 💡 Tips & Tricks

1. **Save common presets**: Make note of your preferred bitrate/sample rate
2. **Test with small files**: Try a short video first to verify settings
3. **Use stereo for music**: Keeps full frequency range
4. **Backup important conversions**: Cloud storage for safety
5. **Close unused tabs**: Speeds up conversion process

---

## 🔄 Updates & Support

This application uses the latest **FFmpeg.wasm** from CDN, so you automatically get:
- Latest video codec support
- Security updates
- Performance improvements
- Bug fixes

No manual updates needed!

---

## 📜 License

This tool is provided as-is for personal and educational use. FFmpeg is used under its respective license (LGPL).

---

## 🚀 Getting Started Right Now

1. Double-click `index.html` to open in your default browser
2. Or right-click and select "Open with → Your preferred browser"
3. Bookmark it for quick access
4. Share the file with friends - it's completely standalone!

---

## 🎯 Key Highlights

| Feature | Status |
|---------|--------|
| Offline Processing | ✅ Complete |
| Multiple Formats | ✅ 6 formats |
| Quality Control | ✅ Bitrate/Sample Rate |
| Progress Tracking | ✅ Real-time |
| Responsive Design | ✅ Mobile-friendly |
| Drag & Drop | ✅ Supported |
| No Sign-up Required | ✅ Anonymous |
| Privacy Protected | ✅ No servers |
| Error Handling | ✅ Comprehensive |
| Modern UI | ✅ Beautiful design |

---

**Enjoy fast, private, and reliable audio extraction! 🎵**

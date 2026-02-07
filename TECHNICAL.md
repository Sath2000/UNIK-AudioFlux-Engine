# 🔧 Technical Documentation

## Architecture Overview

```
┌─────────────────────────────────────────┐
│     Browser (HTML/CSS/JavaScript)       │
├─────────────────────────────────────────┤
│   User Interface Layer                  │
│   - File upload handlers                │
│   - Format selection                    │
│   - Progress tracking                   │
├─────────────────────────────────────────┤
│   Processing Layer                      │
│   - FFmpeg command builder              │
│   - File I/O operations                 │
│   - Blob generation                     │
├─────────────────────────────────────────┤
│   FFmpeg.wasm (WebAssembly)             │
│   - Video codec support                 │
│   - Audio extraction                    │
│   - Format conversion                   │
└─────────────────────────────────────────┘
```

---

## Code Structure

### 1. **FFmpeg Initialization**
```javascript
// Loads FFmpeg WebAssembly module
const state = {
    ffmpeg: new FFmpeg.FFmpeg(),
    isFFmpegReady: false,
};

// Initializes with CDN-hosted core files
await state.ffmpeg.load({
    coreURL: baseURL + '/ffmpeg-core.js',
    wasmURL: baseURL + '/ffmpeg-core.wasm',
});
```

### 2. **File Upload Handler**
```javascript
// Accepts both click and drag-drop
function handleFileSelect(file) {
    // Validates video MIME type
    // Updates UI with file info
    // Enables convert button
}
```

### 3. **Conversion Engine**
```javascript
// Main FFmpeg execution
async function convertVideo() {
    // 1. Load video into FFmpeg's virtual filesystem
    // 2. Build FFmpeg command based on settings
    // 3. Execute conversion
    // 4. Extract output as Blob
    // 5. Clean up temporary files
}
```

### 4. **Format Codec Mapping**
```javascript
const codecMap = {
    'mp3': 'libmp3lame',    // MP3 encoding
    'wav': 'pcm_s16le',     // WAV (uncompressed)
    'aac': 'aac',           // AAC encoding
    'flac': 'flac',         // FLAC (lossless)
    'ogg': 'libvorbis',     // Ogg Vorbis encoding
    'm4a': 'aac',           // M4A (AAC in MP4 container)
};
```

---

## Key Variables & State

| Variable | Type | Purpose |
|----------|------|---------|
| `state.ffmpeg` | Object | FFmpeg.wasm instance |
| `state.videoFile` | File | Uploaded video |
| `state.outputFormat` | String | Selected output format |
| `state.isProcessing` | Boolean | Conversion in progress |
| `state.isFFmpegReady` | Boolean | FFmpeg loaded |
| `state.generatedBlob` | Blob | Converted audio file |

---

## FFmpeg Command Structure

### Basic Format
```bash
ffmpeg -i input_video -vn -acodec <codec> -b:a <bitrate>k -ar <samplerate> -ac <channels> output.<ext>
```

### Example: MP3 Conversion
```bash
ffmpeg \
  -i input_video \
  -vn \
  -acodec libmp3lame \
  -b:a 192k \
  -ar 44100 \
  -ac 2 \
  output.mp3
```

### Command Parameters
| Parameter | Meaning |
|-----------|---------|
| `-i` | Input file |
| `-vn` | No video stream |
| `-acodec` | Audio encoder |
| `-b:a` | Audio bitrate |
| `-ar` | Audio sample rate |
| `-ac` | Audio channels |

---

## Progress Tracking

### Conversion Progress States
1. **Loading** (0-15%) - Read video file
2. **Preparing** (15-30%) - Initialize conversion
3. **Converting** (30-85%) - Main processing
4. **Finalizing** (85-95%) - Extract output
5. **Complete** (95-100%) - Ready to download

### Real-time Updates
```javascript
function updateProgress(percentage) {
    elements.progressFill.style.width = `${percentage}%`;
}
```

---

## Error Handling

### Types of Errors
1. **File Upload Errors**
   - Non-video files
   - Corrupted files
   - Oversized files

2. **FFmpeg Errors**
   - Failed initialization
   - Unsupported codecs
   - Memory issues

3. **Conversion Errors**
   - Invalid format combinations
   - Codec incompatibility
   - Insufficient memory

### Error Display
```javascript
showStatus('error', 'Title', 'Detailed error message');
```

---

## Browser APIs Used

### File Handling
```javascript
// File reading
const videoData = await fetchFile(state.videoFile);

// Blob creation
const blob = new Blob([data.buffer], { type: 'audio/mpeg' });

// Object URLs
const url = URL.createObjectURL(blob);
```

### DOM Manipulation
- Event listeners for file upload
- Drag & drop handlers
- Dynamic UI updates

### Storage (None)
- No localStorage use
- No IndexedDB use
- Everything in memory

---

## FFmpeg.wasm Specifications

### Version
- **@ffmpeg/ffmpeg**: 0.12.6
- **@ffmpeg/util**: 0.12.0

### Core Files (CDN)
- `ffmpeg-core.js` - JavaScript wrapper
- `ffmpeg-core.wasm` - WebAssembly binary (~30MB)

### Memory Management
- Allocates virtual filesystem in memory
- Automatically cleans up files after conversion
- Watch browser memory for large files

---

## Performance Characteristics

### Conversion Time Estimates
```
100MB video  → ~1-2 min
500MB video  → ~5-10 min
1GB video    → ~10-20 min
```

### Factors Affecting Speed
- Video codec complexity
- Output format
- Selected bitrate
- Computer CPU power
- Browser implementation

### Memory Usage
- Input file: ~1x (stored in memory)
- Workspace: ~500MB (FFmpeg allocation)
- Output file: Variable (based on bitrate)

---

## Audio Quality Metrics

### MP3 Quality by Bitrate
| Bitrate | Quality | Use Case |
|---------|---------|----------|
| 128 kbps | Acceptable | Streaming, Speech |
| 192 kbps | Good | General Listening |
| 256 kbps | High | Music Appreciation |
| 320 kbps | Excellent | Archival, Professional |

### Sample Rates
| Rate | Use | Note |
|------|-----|------|
| 44.1 kHz | CD Audio | Standard |
| 48 kHz | Professional | Broadcast |
| 96 kHz | Audiophile | High-res |

---

## Security Considerations

### What's Secure
- ✅ Client-side only processing
- ✅ No network transmission of files
- ✅ No server storage
- ✅ No tracking or logging

### What to Monitor
- Large file sizes (memory implications)
- Browser security sandbox limits
- CORS for external CDN resources

---

## Extending the Application

### Adding a New Format
1. Add radio button in HTML
2. Add codec mapping in `codecMap`
3. Test with sample video

Example:
```javascript
// In codecMap
'opus': 'libopus',  // New format

// In HTML
<input type="radio" id="format-opus" name="format" value="opus" />
<label for="format-opus" class="format-label">Opus</label>
```

### Custom FFmpeg Commands
Modify the command builder:
```javascript
// Locate: "// Build FFmpeg command"
// Add custom parameters as needed
ffmpegCommand.push('-filter:a', 'volume=0.9'); // Example: volume reduction
```

### Batch Processing Implementation
```javascript
// Would need:
// 1. File queue management
// 2. Sequential processing
// 3. Progress per file
// 4. Bulk download
```

---

## Deployment

### As Local File
1. Save `index.html` anywhere
2. Open directly in browser
3. No server required

### As Web Server
```bash
# Python
python -m http.server 8000

# Node.js (http-server)
http-server

# Any static file server
```

### Considerations
- Works with HTTPS required by some browsers
- CDN access needed for first load
- Subsequent uses work offline

---

## Browser Compatibility Testing

### Tested Browsers
- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

### Mobile Testing
- Chrome Android
- Firefox Mobile
- Safari iOS 14+

---

## Debugging

### Enable FFmpeg Logging
FFmpeg logs are automatically logged to console:
```
[FFmpeg info] ...
[FFmpeg warning] ...
[FFmpeg error] ...
```

### Check Status in Console
```javascript
// Check FFmpeg readiness
console.log(state.isFFmpegReady);

// Check loaded files
console.log(state.ffmpeg.FS.readdir('/'));
```

---

## Dependencies

### External Libraries (CDN)
- FFmpeg.wasm (@ffmpeg/ffmpeg)
- FFmpeg Util (@ffmpeg/util)

### No Node.js Or Build Tools Required
- Pure vanilla JavaScript
- No bundler needed
- Single HTML file deployment

---

## Future Enhancement Ideas

1. **Batch Processing**: Convert multiple videos
2. **Format Presets**: Save user preferences
3. **Metadata Editing**: Edit audio ID3 tags
4. **Advanced Filtering**: Audio effects, EQ
5. **Streaming API**: Direct to cloud storage
6. **Theme Customization**: Dark mode, colors
7. **Language Support**: Multi-language UI
8. **Audio Visualization**: Waveform display

---

## Performance Optimization Tips

### For End Users
- Use Chrome/Edge (faster than Firefox)
- Close other browser tabs
- Use lower bitrate for speed
- Monitor system resources

### For Developers
- Lazy-load FFmpeg only when needed
- Cache FFmpeg in browser cache
- Implement chunked processing for ultra-large files
- Consider WebWorker for non-blocking UI

---

## Resources

### Official Documentation
- [FFmpeg.wasm Documentation](https://ffmpegwasm.netlify.app/)
- [FFmpeg Documentation](https://ffmpeg.org/documentation.html)

### Related Tools
- FFmpeg (Original)
- mpg123 (Audio playback)
- LAME (MP3 encoding)

---

**Built with ❤️ using FFmpeg.wasm**

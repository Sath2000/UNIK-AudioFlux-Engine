# 🆘 Troubleshooting Guide

## Common Issues & Solutions

---

## 🔴 FFmpeg Loading Issues

### Issue: "⏳ Loading FFmpeg..." never completes

**Causes:**
- Slow internet connection
- CDN server down
- Browser cache issue
- JavaScript disabled

**Solutions:**
1. **Wait longer** (up to 30 seconds on slow connection)
2. **Check internet**: Try another website
3. **Clear cache**: 
   ```
   Chrome: Ctrl+Shift+Del → Clear browsing data → All time
   Firefox: Ctrl+Shift+Del → Clear All
   Safari: Cmd+Y → Show history → Clear
   ```
4. **Try different browser**: Chrome usually fastest
5. **Refresh page**: Ctrl+R or browser refresh button
6. **Check console errors**: F12 → Console → Look for red errors

**If still failing:**
- Switch to wired internet (faster/more stable)
- Try another device
- Contact ISP if CDN access blocked

---

### Issue: "❌ FFmpeg Failed" error message

**Causes:**
- Corruption during download
- Browser crash
- Memory limitation
- Firewall blocking

**Solutions:**
1. **Hard refresh**: Ctrl+Shift+R (clears all cache)
2. **Restart browser**: Close all windows, reopen
3. **Check other tabs**: Close unnecessary tabs to free memory
4. **Run on desktop**: Mobile has memory limitations
5. **Try incognito mode**: Reduces extensions/cache issues
6. **Disable VPN**: May interfere with CDN access

---

## 📁 File Upload Issues

### Issue: Can't select or upload video

**Possible causes:**
- File browser not opening
- File is not a video
- File permissions

**Solutions:**
1. **Click directly on upload zone** (not edges)
2. **Drag & drop instead**: Drag file onto upload zone
3. **Check file type**:
   - Right-click file → Properties
   - Should say "Video" type
   - Valid: MP4, MKV, AVI, MOV, etc.
4. **Try different browser**
5. **Restart browser**

---

### Issue: Video uploaded but shows error after processing

**Causes:**
- Unsupported video codec
- Corrupted video file
- Unsupported audio codec
- Memory insufficient

**Solutions:**
1. **Try different format**: Some formats need specific codec
2. **Test file**: Try small portion of video (convert just first 30 seconds)
3. **Convert video first**: 
   - Use VLC to convert to MP4 first
   - Then upload to converter
4. **Free memory**: 
   - Close other apps
   - Restart computer
   - Reboot browser
5. **Try different browser**: Hardware acceleration differs

---

## ⏱️ Conversion Speed Issues

### Issue: Conversion is very slow

**Typical Times:**
- 100 MB = 1-2 minutes
- 500 MB = 5-10 minutes
- 1 GB = 15-30 minutes

**If slower than this:**

**Check:**
1. **CPU usage**: Open Task Manager
   - Windows: Ctrl+Shift+Esc
   - Mac: Cmd+Space → Activity Monitor
   - Look for browser using 90%+ CPU (normal while converting)

2. **RAM available**:
   - Should have 2+ GB free
   - Close other apps if low

3. **Video format**:
   - H.265 (HEVC) is slower than H.264
   - Try H.264 videos

**Solutions:**
1. **Close other apps/tabs**:
   - Word, Excel, VS Code
   - YouTube, Netflix
   - Other browser tabs

2. **Reduce quality settings**:
   - Lower bitrate (128-192 instead of 320)
   - Lower sample rate (44.1 instead of 96)
   - Use Mono instead of Stereo

3. **Smaller files**:
   - Split video file
   - Convert lower resolution version

4. **Better hardware**:
   - New computers are faster
   - Laptop vs desktop (desktop usually faster)

---

### Issue: Browser seems frozen/unresponsive

**Causes:**
- Heavy processing
- Insufficient RAM
- Browser tab crash

**Solutions:**
1. **Wait**: Processing is intensive, may appear frozen
2. **Monitor progress**: Watch progress bar
3. **Check Task Manager**: See if browser is still processing
4. **If truly frozen**:
   - Wait 5 more minutes
   - If still frozen: Force close browser
   - Start over with smaller file

---

## 🔊 Audio Quality Issues

### Issue: Output audio sounds bad/distorted

**Causes:**
- Bitrate too low
- Original video audio damaged
- Codec mismatch

**Solutions:**
1. **Increase bitrate**:
   - Click Advanced Options
   - Change to 256 or 320 kbps
   - Try again

2. **Test original video**:
   - Play video in Windows Media Player
   - If audio bad there, problem is original

3. **Try lossless format**:
   - Converts without loss: WAV or FLAC
   - See if intermediate format helps

4. **Check speaker/headphones**:
   - Try different speakers
   - Might be playback issue

---

### Issue: No audio in output file

**Causes:**
- Video has no audio track
- Failed audio extraction
- Silent audio extraction

**Solutions:**
1. **Verify original**:
   - Play video
   - Check if it has sound
   - If no sound in video, converter can't extract it

2. **Try different format**:
   - Some formats handle silent better
   - Try WAV format

3. **Check with other software**:
   - Open output in VLC
   - Try playing in different player

---

## 💾 Download Issues

### Issue: Download doesn't start or fails

**Causes:**
- Browser download settings
- File too large for browser
- JavaScript interference

**Solutions:**
1. **Check browser settings**:
   - Chrome: Menu → Settings → Privacy → Downloads
   - Firefox: File → Preferences → Files
   - Verify downloads are enabled

2. **Check download folder**:
   - Sometimes browser saves automatically
   - Look in Downloads folder
   - May be partially downloaded

3. **Download manually**:
   ```
   Right-click download link → Save as
   Your Desktop or Documents folder
   ```

4. **Check file size**:
   - Huge files may fail
   - Try smaller video or lower bitrate

5. **Disable extensions**:
   - Ad blockers can interfere
   - Disable temporarily
   - Try download again

---

### Issue: "File already exists" error

**Causes:**
- File with same name already exists
- Browser protection

**Solutions:**
1. **Rename file**: Add number (audio_2.mp3)
2. **Clear Downloads folder**: Delete old files
3. **Use different name**: Download as different format
4. **Use "Save as" dialog**: Right-click link → Save as

---

## 🌐 Browser-Specific Issues

### Chrome Issues

**Blank page/Won't load:**
```
1. Hard refresh: Ctrl+Shift+R
2. Clear cache: Ctrl+Shift+Del
3. Update Chrome: Menu → Help → About Chrome
4. Try incognito mode: Ctrl+Shift+N
```

**Slow conversion:**
```
1. Check extensions: Extensions off in incognito
2. Disable: Ad-block, VPN, privacy tools
3. Update Chrome
4. Different browser
```

---

### Firefox Issues

**"Add-ons block" message:**
```
1. Click "Allow" when prompted
2. Or: Preferences → Privacy & Security → Allow
```

**Memory issues:**
```
1. Close other tabs
2. Restart Firefox
3. Clear history: Ctrl+Shift+Del
```

---

### Safari Issues

**WebAssembly not supported (older Safari):**
```
Update to Safari 14+
Or use Chrome/Firefox instead
```

**Permission denied:**
```
Safari → Preferences → Security → Allow
```

---

### Mobile Browser Issues

**Getting "File too large" **
```
Solution:
1. Use smaller video files
2. Close other apps
3. Switch to desktop
```

**Touch interface issues:**
```
1. Double-tap upload zone
2. Try tap-and-hold on file
3. Drag-drop may not work on mobile
```

---

## 🔐 Security & Privacy Issues

### Issue: Browser warning about "Unsafe"

**Cause:**
- JavaScript enabled locally
- Normal behavior for local HTML files

**Solutions:**
1. **This is normal**: Local HTML files show warnings
2. **Safe to use**: All processing is local
3. **If concerned**:
   - Deploy to HTTPS server
   - Warnings disappear
   - See DEPLOYMENT.md

---

### Issue: "Do you want to allow JavaScript?"

**Solutions:**
1. **Click YES/ALLOW**
2. **This app requires JavaScript**
3. Without it, nothing works

---

## 📱 Mobile-Specific Issues

### Issue: App won't work on phone/tablet

**Check:**
1. Modern browser installed
   - Chrome 60+
   - Firefox 55+
   - Safari 14+
2. Sufficient RAM (1GB+)
3. Video not too large (under 500MB ideal)

**Solutions:**
1. **Update browser**: App store update
2. **Close other apps**: Free up RAM
3. **Use WiFi**: Faster, more stable
4. **Try desktop version**: More RAM available

---

### Issue: Downloaded file saved to strange location

**Causes:**
- Default browser download behavior
- No control over location

**Solutions:**
1. **Check Downloads folder** first
2. **Check Documents folder**
3. **Search for file**: 
   - Windows: Win+Q → type filename
   - Mac: Cmd+Space → type filename
4. **Configure download location**: Browser settings

---

## 💬 Error Messages Explained

| Error | Meaning | Fix |
|-------|---------|-----|
| "FFmpeg Failed" | WASM not loaded | Refresh page, check internet |
| "Invalid File" | Not a video | Upload video file (.mp4, etc) |
| "Conversion Failed" | Processing error | Try different format |
| "File too large" | Memory issue | Use smaller file |
| "No audio stream" | Video has no audio | Original video has no audio |
| "Unsupported format" | Codec not supported | Convert video first |

---

## 🔍 Advanced Troubleshooting

### Check Browser Console
```
Press: F12 (Windows/Linux) or Cmd+Option+I (Mac)
Go to: Console tab
Look for red error messages
Copy text and search online for solution
```

### Check Network Tab
```
F12 → Network tab
Look for failed(red) downloads
Usually CDN or internet issue
```

### System Resource Check

**Windows:**
```powershell
# Check memory
Get-CimInstance Win32_ComputerSystem | Select-Object TotalPhysicalMemory
```

**Mac:**
```bash
# Check memory
vm_stat
```

---

## 🆘 Still Having Issues?

### Checklist Before Official Help
- [ ] Tried refreshing page (Ctrl+R)
- [ ] Tried different browser
- [ ] Closed other tabs/apps
- [ ] Restarted browser completely
- [ ] Cleared cache (Ctrl+Shift+Del)
- [ ] Checked browser console (F12)
- [ ] Tried wired internet connection
- [ ] Updated browser version
- [ ] Used smaller video file for testing

### Report Issue With
1. **Browser**: Chrome 120, Firefox 121, etc.
2. **OS**: Windows 11, Mac OS 13, etc.
3. **Video size**: MB
4. **Video format**: MP4, MKV, etc.
5. **Error message**: Exact text from console
6. **Steps to reproduce**: What you did

---

## 📞 Getting Help Online

### Search Terms That Help
- "FFmpeg.wasm error"
- "WebAssembly not supported"
- "Video codec unsupported"
- File format name + "convert"

### Useful Resources
- FFmpeg.wasm Docs: ffmpegwasm.netlify.app
- Stack Overflow: Tag [ffmpeg]
- GitHub Issues: ffmpeg/ffmpeg

---

**Remember: This runs completely locally - no servers involved!**
**If it doesn't work, it's usually one of:**
1. Internet needed for initial load
2. Browser doesn't support WebAssembly
3. File or format issue

**Restart and try again!** 🔄

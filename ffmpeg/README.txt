Vendor FFmpeg Core Files

To enable local (vendored) FFmpeg.wasm support, download the official core files and place them in this folder:

Required files (place inside the "ffmpeg" folder):
- ffmpeg.min.js        (the JavaScript wrapper, e.g. from @ffmpeg/ffmpeg dist)
- ffmpeg-core.js       (the loader/runtime script)
- ffmpeg-core.wasm     (the wasm binary)

Suggested sources:
- Official package on npm: https://www.npmjs.com/package/@ffmpeg/ffmpeg
- You may download the dist files from a registry or use the package to extract them.

Quick manual steps:
1. On a machine with Node.js installed, run:
   npm pack @ffmpeg/ffmpeg@0.12.6
   tar -xzf @ffmpeg_ffmpeg-0.12.6.tgz
   # extract files from package/dist and copy ffmpeg.min.js and core files to this folder

2. Or obtain the dist files from a trusted CDN and save them here with the exact names above.

Notes:
- The `.wasm` file is typically large (tens of MB). Make sure your hosting and git workflow can handle it (you may prefer to host the .wasm externally if needed).
- After placing the files, reload the page. The app will detect the local files and initialize FFmpeg from /ffmpeg.

If you want, I can attempt to download and place these files locally for you, but this environment may have network restrictions.

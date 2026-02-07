// Service Worker for EveryVideo Audio Extractor & Converter
// Enables offline functionality after first load

const CACHE_NAME = 'everyvideoconverter-v1';
const ASSETS_TO_CACHE = [
    '/',
    '/index.html',
    '/manifest.json',
];

const EXTERNAL_CACHE = 'ffmpeg-wasm-v1';
const EXTERNAL_RESOURCES = [
    'https://cdn.jsdelivr.net/npm/@ffmpeg/ffmpeg@0.12.6/dist/ffmpeg.min.js',
    'https://cdn.jsdelivr.net/npm/@ffmpeg/util@0.12.0/dist/util.min.js',
    'https://cdn.jsdelivr.net/npm/@ffmpeg/core@0.12.6/dist/esm/ffmpeg-core.js',
    'https://cdn.jsdelivr.net/npm/@ffmpeg/core@0.12.6/dist/esm/ffmpeg-core.wasm',
];

// Install event: Cache essential assets
self.addEventListener('install', (event) => {
    console.log('[ServiceWorker] Installing...');
    
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => {
                console.log('[ServiceWorker] Caching app shell');
                return cache.addAll(ASSETS_TO_CACHE);
            })
            .then(() => self.skipWaiting())
    );
});

// Activate event: Clean up old caches
self.addEventListener('activate', (event) => {
    console.log('[ServiceWorker] Activating...');
    
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheName !== CACHE_NAME && cacheName !== EXTERNAL_CACHE) {
                        console.log('[ServiceWorker] Deleting old cache:', cacheName);
                        return caches.delete(cacheName);
                    }
                })
            );
        }).then(() => self.clients.claim())
    );
});

// Fetch event: Network-first strategy with fallback to cache
self.addEventListener('fetch', (event) => {
    const { request } = event;
    const url = new URL(request.url);

    // Skip non-GET requests
    if (request.method !== 'GET') {
        return;
    }

    // Strategy for app files: Cache-first (network fallback)
    if (url.origin === self.location.origin) {
        event.respondWith(
            caches.match(request)
                .then((response) => {
                    if (response) {
                        return response;
                    }
                    
                    return fetch(request).then((response) => {
                        // Don't cache non-successful responses
                        if (!response || response.status !== 200 || response.type === 'error') {
                            return response;
                        }

                        // Cache successful responses
                        const responseToCache = response.clone();
                        caches.open(CACHE_NAME).then((cache) => {
                            cache.put(request, responseToCache);
                        });

                        return response;
                    }).catch(() => {
                        // Fallback for offline
                        return caches.match(request) || 
                               new Response('Offline - Page not available', {
                                   status: 503,
                                   statusText: 'Service Unavailable',
                                   headers: new Headers({
                                       'Content-Type': 'text/plain'
                                   })
                               });
                    });
                })
        );
    }

    // Strategy for external resources: Network-first with cache fallback
    if (EXTERNAL_RESOURCES.some(resource => request.url.includes(resource))) {
        event.respondWith(
            fetch(request)
                .then((response) => {
                    // Cache successful external resources
                    if (response && response.status === 200) {
                        const responseToCache = response.clone();
                        caches.open(EXTERNAL_CACHE).then((cache) => {
                            cache.put(request, responseToCache);
                        });
                    }
                    return response;
                })
                .catch(() => {
                    // Fallback to cache for FFmpeg resources
                    return caches.match(request);
                })
        );
    }
});

// Message handler for cache management
self.addEventListener('message', (event) => {
    if (event.data.action === 'skipWaiting') {
        self.skipWaiting();
    }
    
    if (event.data.action === 'clearCache') {
        caches.delete(CACHE_NAME).then(() => {
            event.ports[0].postMessage({ success: true });
        });
    }
    
    if (event.data.action === 'cacheStatus') {
        caches.open(CACHE_NAME).then((cache) => {
            cache.keys().then((keys) => {
                event.ports[0].postMessage({ 
                    cached: keys.length,
                    files: keys.map(k => k.url)
                });
            });
        });
    }
});

console.log('[ServiceWorker] Service Worker ready');

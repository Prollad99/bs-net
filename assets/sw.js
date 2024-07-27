const CACHE_NAME = 'my-app-cache-v1'; // Update cache version as needed
const urlsToCache = [
  '/assets/css/styles.css',
  '/assets/icons/icon-192x192.png',
  '/assets/icons/icon-512x512.png',
  '/assets/js/timeAgo.js',
];

// Install event
self.addEventListener('install', event => {
  console.log('Service Worker installing.');
  event.waitUntil(
    caches.open(CACHE_NAME)
    .then(cache => {
      console.log('Caching app assets');
      return cache.addAll(urlsToCache);
    })
  );
});

// Fetch event
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
    .then(response => {
      return response || fetch(event.request);
    })
  );
});

// Activate event
self.addEventListener('activate', event => {
  console.log('Service Worker activating.');
});
const CACHE_NAME = '{{ page.title | replace: ' ', '-' | downcase }}-static-cache';
const urlsToCache = [
  '{{ page.url }}',
  '{{ page.url }}index.html',
  '{{ page.url }}manifest.json',
  '{{ site.baseurl }}/assets/css/styles.css',
  '{{ site.baseurl }}/assets/icons/icon-192x192.png',
  '{{ site.baseurl }}/assets/icons/icon-512x512.png'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      return cache.addAll(urlsToCache);
    })
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request).then(response => {
      return response || fetch(event.request);
    })
  );
});
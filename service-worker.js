const CACHE_NAME = '{{ page.url | slugify }}-cache-v1';
const urlsToCache = [
  '{{ page.url }}',
  '{{ site.baseurl }}/assets/css/styles.css',
  '{{ site.baseurl }}/assets/js/timeAgo.js'
];

self.addEventListener('install', function(event) {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(function(cache) {
        return cache.addAll(urlsToCache);
      })
  );
});

self.addEventListener('fetch', function(event) {
  event.respondWith(
    caches.match(event.request)
      .then(function(response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      }
    )
  );
});
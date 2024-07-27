self.addEventListener('install', event => {
  const appName = 'app-name-placeholder'; // Replace with your dynamic logic if needed
  event.waitUntil(
    caches.open(`${appName}-static-cache`).then(cache => {
      return cache.addAll([
        '{{ site.baseurl }}/assets/css/styles.css',
        '{{ site.baseurl }}/assets/icons/icon-192x192.png',
        '{{ site.baseurl }}/assets/icons/icon-512x512.png',
        '{{ site.baseurl }}/assets/js/timeAgo.js',
      ]);
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
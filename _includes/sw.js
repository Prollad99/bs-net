self.addEventListener('install', event => {
  event.waitUntil(
    caches.open('{{ page.title | replace: ' ', '-' | downcase }}-static-cache').then(cache => {
      return cache.addAll([
        '{{ page.url }}',
        '{{ page.url }}index.html',
        '{{ site.baseurl }}/manifest.json',
        '{{ site.baseurl }}/assets/css/styles.css',
        '{{ site.baseurl }}/assets/icons/icon-192x192.png',
        '{{ site.baseurl }}/assets/icons/icon-512x512.png'
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
document.addEventListener('DOMContentLoaded', function() {
  const button = document.getElementById('load-more-btn');
  if (button) {
    button.addEventListener('click', function() {
      const nextPage = button.getAttribute('data-next-page');
      if (nextPage) {
        fetch(nextPage)
          .then(response => response.text())
          .then(html => {
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            const newPosts = doc.querySelectorAll('.post');
            const postsContainer = document.querySelector('.posts');
            newPosts.forEach(post => postsContainer.appendChild(post));
            const newNextPage = doc.querySelector('#load-more-btn')?.getAttribute('data-next-page');
            if (newNextPage) {
              button.setAttribute('data-next-page', newNextPage);
            } else {
              button.remove();
            }
          })
          .catch(error => {
            console.error('Error loading more posts:', error);
          });
      }
    });
  }
});
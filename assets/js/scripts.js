function timeAgo(dateString) {
    const now = new Date();
    const date = new Date(dateString);

    // Convert current time (now) to IST (UTC+5:30)
    const offsetIST = 5 * 60 + 30; // 5 hours 30 minutes in minutes
    now.setMinutes(now.getMinutes() + now.getTimezoneOffset() + offsetIST);

    const seconds = Math.floor((now - date) / 1000);
    let interval = Math.floor(seconds / 31536000);

    if (interval > 1) return `${interval} years ago`;
    if (interval === 1) return `1 year ago`;

    interval = Math.floor(seconds / 2592000);
    if (interval > 1) return `${interval} months ago`;
    if (interval === 1) return `1 month ago`;

    interval = Math.floor(seconds / 86400);
    if (interval > 1) return `${interval} days ago`;
    if (interval === 1) return `1 day ago`;

    interval = Math.floor(seconds / 3600);
    if (interval > 1) return `${interval} hours ago`;
    if (interval === 1) return `1 hour ago`;

    interval = Math.floor(seconds / 60);
    if (interval > 1) return `${interval} minutes ago`;
    if (interval === 1) return `1 minute ago`;

    return `${Math.floor(seconds)} seconds ago`;
}

document.addEventListener('DOMContentLoaded', function() {
    const lastUpdatedElement = document.getElementById('last-updated');
    if (lastUpdatedElement) {
        const lastModifiedDate = lastUpdatedElement.getAttribute('data-last-modified');
        lastUpdatedElement.textContent = timeAgo(lastModifiedDate);
    }
});
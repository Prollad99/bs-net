function timeAgo(dateString) {
    const now = new Date();
    const date = new Date(dateString);

    // Convert both dates to UTC
    const nowUTC = new Date(now.toUTCString().slice(0, -4));
    const dateUTC = new Date(date.toUTCString().slice(0, -4));

    const seconds = Math.floor((nowUTC - dateUTC) / 1000);
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
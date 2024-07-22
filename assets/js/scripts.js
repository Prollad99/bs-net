function timeAgo(dateString) {
    // Convert the provided date string to a Date object in UTC
    const date = new Date(dateString);
    
    // Calculate the difference in milliseconds
    const now = new Date();
    const offset = now.getTimezoneOffset() * 60000; // Offset in milliseconds
    const localNow = new Date(now.getTime() - offset); // Local time in milliseconds
    const localDate = new Date(date.getTime() + offset); // Adjust date to local time
    
    const seconds = Math.floor((localNow - localDate) / 1000);
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
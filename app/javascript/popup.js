// JavaScript functions to show and hide the popup
import { sendGtagEvent } from "tracking"

export function showPopup(postId) {
    var popup = document.getElementById('popup-' + postId);
    popup.classList.add('display-block');
    document.body.classList.add('popup-active');
    sendGtagEvent('views_per_post', 'post_view', postId);

    // Check if the post ID is already in the URL, if not, add it
    const currentUrl = new URL(window.location.href);
    const currentPostId = currentUrl.searchParams.get('post');
    if (currentPostId !== postId) {
        // If there is no post parameter, or if it's different, update it
        currentUrl.searchParams.set('post', postId);
        window.history.replaceState({ postId }, '', currentUrl.toString());
    }
}

export function hidePopup(postId) {
    var popup = document.getElementById('popup-' + postId);
    if (popup) {
        popup.classList.remove('display-block');
        document.body.classList.remove('popup-active');
    }
    // Create a new URL object based on the current location
    const currentUrl = new URL(window.location.href);
    // Remove the 'post' query parameter
    currentUrl.searchParams.delete('post');
    // Update the browser's URL without reloading the page
    window.history.replaceState({}, '', currentUrl.toString());
}
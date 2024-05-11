// JavaScript functions to show and hide the popup
export function showPopup(postId) {
    var popup = document.getElementById('popup-' + postId);
    popup.style.display = 'block';
}

export function hidePopup(postId) {
    var popup = document.getElementById('popup-' + postId);
    popup.style.display = 'none';
}
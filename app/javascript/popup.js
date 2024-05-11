// JavaScript functions to show and hide the popup
export function showPopup(postId) {
    var popup = document.getElementById('popup-' + postId);
    popup.style.display = 'block';
    document.body.classList.add('popup-active');
}

export function hidePopup(postId) {
    var popup = document.getElementById('popup-' + postId);
    popup.style.display = 'none';
    document.body.classList.remove('popup-active');
}
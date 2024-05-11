// JavaScript functions to show and hide the popup
export function showPopup(postId) {
    var popup = document.getElementById('popup-' + postId);
    popup.classList.add('display-block');
    document.body.classList.add('popup-active');
}

export function hidePopup(postId) {
    var popup = document.getElementById('popup-' + postId);
    if (popup) {
        popup.classList.remove('display-block');
        document.body.classList.remove('popup-active');
    }
}
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import { showPopup, hidePopup } from "./popup"


document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.card.blog-card').forEach(card => {
        card.addEventListener('click', (e) => {
        e.preventDefault();
        const postId = card.getAttribute('data-post-id');
        showPopup(postId);
        });
    });
  
    document.querySelectorAll('.popup .close').forEach(closeBtn => {
        closeBtn.addEventListener('click', () => {
        const popup = closeBtn.closest('.popup');
        const postId = popup.getAttribute('data-post-id');
        hidePopup(postId);
        });
    });
});
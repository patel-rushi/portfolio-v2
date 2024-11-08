// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import { showPopup, hidePopup } from "popup"
import { sendGtagEvent } from "tracking"
import { openDropdown, closeDropdown } from "diary-category-dropdown"

window.sendGtagEvent = sendGtagEvent;
window.openDropdown = openDropdown;

function attachEventListeners() {
    // Show popup
    document.querySelectorAll('.card.blog-card, .link_pop_up').forEach(card => {
        card.addEventListener('click', (e) => {
        e.preventDefault();
        const postId = card.getAttribute('data-post-id');
        showPopup(postId);
        });
    });
    // Close popup on cross button
    document.querySelectorAll('.popup .close').forEach(closeBtn => {
        closeBtn.addEventListener('click', () => {
        const popup = closeBtn.closest('.popup');
        const postId = popup.getAttribute('data-post-id');
        hidePopup(postId);
        });
    });

    // Close popup when clicking outside of it
    window.addEventListener('click', (event) => {
        const openPopup = document.querySelector('.popup.display-block');
        if (openPopup && openPopup.contains(event.target)) {
            const postId = openPopup.getAttribute('data-post-id');
            hidePopup(postId);
        }
    });

    // Close diary category when clicking outside of it
    window.addEventListener('click', (event) => {
        closeDropdown(event);
    });
}
// Listen for Turbo events
document.addEventListener('turbo:load', attachEventListeners);
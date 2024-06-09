import { sendGtagEvent } from "tracking";
import { showPopup } from 'popup';

export function initializePopup(openPostId) {
    if (openPostId) {
        document.addEventListener('DOMContentLoaded', () => {
            console.log(`popup-${openPostId}`);
            showPopup(openPostId);
            var card = document.querySelector(`[data-post-id="${openPostId}"]`);
            if (card) {
                card.scrollIntoView({ behavior: 'smooth', block: 'center' });
                card.classList.add('extra-border-highlight');
            }
        });
        sendGtagEvent('views_per_page', 'page_view', `tech/${openPostId}`);
    }
}
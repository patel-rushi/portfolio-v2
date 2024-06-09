import { sendGtagEvent } from "tracking";
import { showPopup } from 'popup';

export function initializePopup(openPostId) {
    if (openPostId) {
        document.addEventListener('DOMContentLoaded', () => {
            console.log(`popup-${openPostId}`);
            showPopup(openPostId);
        });
        sendGtagEvent('views_per_page', 'page_view', `tech/${openPostId}`);
    }
}
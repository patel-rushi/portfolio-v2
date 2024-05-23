export function sendGtagEvent(eventAction, eventCategory, eventLabel) {
    gtag('event', eventAction, {
        'event_category': eventCategory,
        'event_label': eventLabel,
    });
    console.log('event', eventAction, {
        'event_category': eventCategory,
        'event_label': eventLabel,
    });
}
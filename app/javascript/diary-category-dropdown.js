export function openDropdown() {
    const dropdownContent = document.querySelector('.dropdown-content');
    if (dropdownContent) {
        dropdownContent.classList.toggle('display-block');
    }
}

export function closeDropdown (event) {
    const dropdownContainer = document.querySelector('.dropdown')
    const openDropdown = document.querySelector('.dropdown-content.display-block');
    if (openDropdown && !dropdownContainer.contains(event.target)) {
        openDropdown.classList.remove('display-block');
    }
}
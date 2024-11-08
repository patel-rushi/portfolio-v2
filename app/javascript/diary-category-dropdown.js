export function openDropdown () {
    var dropdownBtn = document.getElementById('dropbtn-diary');
    var dropdownContent = document.querySelector('.dropdown-content');
    if (dropdownBtn.classList) {
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
export function openDropdown () {
    var dropdownBtn = document.getElementById('dropbtn-diary');
    var dropdownContent = document.querySelector('.dropdown-content');
    if (dropdownBtn.classList) {
        dropdownContent.classList.toggle('display-block');
    }
}

export function closeDropdown () {
    var dropdownContent = document.querySelector('.dropdown-content');
    dropdownContent.classList.remove('display-block');
}
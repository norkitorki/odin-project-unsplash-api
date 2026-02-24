const flash = document.querySelector('.flash');

// Hide flash after approximately 5 seconds
if (flash) {
  setTimeout(() => (flash.style.display = 'none'), 5000);
}

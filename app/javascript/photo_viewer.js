const dataElement = document.querySelector('.photoData');
const photoData = JSON.parse(dataElement?.textContent || '[]');

if (photoData.length > 0) {
  const imageViewerButton = document.querySelector('.imageViewerButton');
  const photoViewer = document.querySelector('.photoViewer');
  const photoCounter = photoViewer.querySelector('.photoCounter');
  const photoDisplay = photoViewer.querySelector('.photoDisplay');
  const closeButton = photoViewer.querySelector('.closeButton');
  const leftArrow = photoViewer.querySelector('.leftArrow');
  const rightArrow = photoViewer.querySelector('.rightArrow');

  let index = 0;

  const openPhotoViewer = () => {
    photoViewer.classList.add('viewerOpen');
    leftArrow.focus();
  };
  const closePhotoViewer = () => photoViewer.classList.remove('viewerOpen');

  const updatePhoto = (indexChange) => {
    index += indexChange;
    if (index < 0) index = photoData.length - 1;
    else if (index >= photoData.length) index = 0;

    const photo = photoData[index];
    photoDisplay.src = photo.urls.regular;
    photoDisplay.alt = photo.alt_description;
    photoCounter.textContent = `${index + 1} / ${photoData.length}`;
  };

  const keyboardNavigation = (event) => {
    if (!photoViewer.classList.contains('viewerOpen')) return;

    if (event.key === 'ArrowLeft') updatePhoto(-1);
    else if (event.key === 'ArrowRight') updatePhoto(1);
    else if (event.key === 'Escape') closePhotoViewer();
  };

  photoViewer.addEventListener('click', (e) => {
    if (e.target !== photoViewer) return;

    if (e.clientX < innerWidth * 0.25) updatePhoto(-1);
    else if (e.clientX >= innerWidth * 0.75) updatePhoto(1);
  });

  window.addEventListener('keydown', keyboardNavigation);
  imageViewerButton.addEventListener('click', openPhotoViewer);
  closeButton.addEventListener('click', closePhotoViewer);
  leftArrow.addEventListener('click', () => updatePhoto(-1));
  rightArrow.addEventListener('click', () => updatePhoto(1));

  updatePhoto(0);
}

document.addEventListener('DOMContentLoaded', () => {
  const sections = document.querySelectorAll('.section');

  const keyframes = {
    opacity: [0, 1],
  };

  sections.forEach(section => {
    if (section) {
      section.animate(keyframes, {
        duration: 2000,
        fill: 'forwards'
      });
    }
  });
});
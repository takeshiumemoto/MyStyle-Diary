document.addEventListener('turbolinks:load', function() {
  const sections = document.querySelectorAll('.background-section');
  sections.forEach(section => {
    section.animate([
      { opacity: 0 },
      { opacity: 1 }
    ], {
      duration: 2000,
      easing: 'ease-out',
      fill: 'forwards'
    });
  });

  const headings = document.querySelectorAll('.overlay h1, .overlay p');
  headings.forEach(heading => {
    const keyframes = {
      opacity: [0, 1],
      transform: ['translateY(50px)', 'translateY(0)']
    };

    const options = {
      duration: 3000,
      easing: 'ease'
    };

    heading.animate(keyframes, options);
  });
});
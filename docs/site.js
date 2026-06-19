(() => {
  const button = document.querySelector('[data-language-toggle]');
  if (!button) return;

  const stored = localStorage.getItem('ballast-language');
  let language = stored || (navigator.language.toLowerCase().startsWith('pt') ? 'pt' : 'en');

  const applyLanguage = () => {
    document.documentElement.lang = language === 'pt' ? 'pt-BR' : 'en';
    document.title = language === 'pt' ? 'Ballast — Volte ao presente' : 'Ballast — Grounding on your wrist';
    document.querySelector('meta[name="description"]')?.setAttribute(
      'content',
      language === 'pt'
        ? 'Ballast guia a técnica dos 5 sentidos 5-4-3-2-1 no Apple Watch.'
        : 'Ballast is a private, haptic-first grounding exercise for Apple Watch.'
    );
    document.querySelectorAll('[data-en][data-pt]').forEach((element) => {
      element.textContent = element.dataset[language];
    });
    document.querySelectorAll('[data-en-src][data-pt-src]').forEach((image) => {
      image.src = image.dataset[`${language}Src`];
    });
    document.querySelectorAll('[data-en-poster][data-pt-poster]').forEach((video) => {
      video.poster = video.dataset[`${language}Poster`];
    });
    button.textContent = language === 'pt' ? 'EN' : 'PT';
    button.setAttribute('aria-label', language === 'pt' ? 'Switch to English' : 'Mudar para português');
    localStorage.setItem('ballast-language', language);
  };

  button.addEventListener('click', () => {
    language = language === 'pt' ? 'en' : 'pt';
    applyLanguage();
  });

  applyLanguage();
})();

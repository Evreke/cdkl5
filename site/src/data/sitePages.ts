export interface SitePage {
  path: string;
  navTitle: string;
  cardTitle: string;
  img: string;
  excerpt: string;
}

export const sitePages: SitePage[] = [
  {
    path: '/about-cdkl5',
    navTitle: 'О CDKL5',
    cardTitle: 'Что такое CDKL5?',
    img: '/img/eeg.webp',
    excerpt:
      'Синдром дефицита CDKL5: симптомы, эпидемиология, диагностика и молекулярная основа заболевания — главное о CDD.',
  },
  {
    path: '/genetics',
    navTitle: 'Генетика CDKL5',
    cardTitle: 'Генетика и анализы',
    img: '/img/dna-rna.webp',
    excerpt:
      'Как прочитать результат генетического анализа: типы мутаций, экзоны и строение белка CDKL5.',
  },
  {
    path: '/treatment',
    navTitle: 'О лечении',
    cardTitle: 'Лечение и поддержка',
    img: '/img/aav.webp',
    excerpt:
      'Контроль судорог, кетогенная диета, VNS, каннабидиол и перспективы генотерапии.',
  },
];

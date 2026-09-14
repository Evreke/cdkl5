export interface SitePage {
  path: string;
  navTitle: string;
  cardTitle: string;
  img: string;
  imgAlt: string;
  excerpt: string;
}

export const sitePages: SitePage[] = [
  {
    path: '/about-cdkl5',
    navTitle: 'О CDKL5',
    cardTitle: 'Что такое CDKL5?',
    img: '/img/eeg.webp',
    imgAlt:
      'ЭЭГ-кривая — пример записи биоэлектрической активности мозга при синдроме дефицита CDKL5',
    excerpt:
      'Синдром дефицита CDKL5: симптомы, эпидемиология, диагностика и молекулярная основа заболевания — главное о CDD.',
  },
  {
    path: '/genetics',
    navTitle: 'Генетика CDKL5',
    cardTitle: 'Генетика и анализы',
    img: '/img/dna-rna.webp',
    imgAlt:
      'Схема двойной спирали ДНК и молекулы РНК — строение гена и белка CDKL5',
    excerpt:
      'Как прочитать результат генетического анализа: типы мутаций, экзоны и строение белка CDKL5.',
  },
  {
    path: '/treatment',
    navTitle: 'О лечении',
    cardTitle: 'Лечение и поддержка',
    img: '/img/aav.webp',
    imgAlt:
      'Схема аденоассоциированного вирусного вектора (AAV) — доставка гена в генотерапии CDKL5',
    excerpt:
      'Контроль судорог, кетогенная диета, VNS, каннабидиол и перспективы генотерапии.',
  },
];

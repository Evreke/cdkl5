# cdkl5

Сайт пациентского сообщества CDKL5 Россия.

## Стек

- [Astro 5](https://astro.build) + [Tailwind CSS 4](https://tailwindcss.com) — статический сайт
- Самохостинговые шрифты Noto Sans (cyrillic + latin)
- Деплой: Docker (node build → nginx), CI — GitHub Actions (staging на PR, prod на merge в `trunk`)

## Разработка

```bash
cd site
npm install
npm run dev      # http://localhost:4321
npm run build    # статики в site/dist
npm run preview  # предпросмотр сборки
```

⚠️ После добавления **новых файлов** перезапустите dev-сервер: Tailwind v4 в dev-режиме
подхватывает классы из новых файлов только при старте (в production-сборке всё сканируется заново).

## Деплой

CI (`.github/workflows/test.yaml`):
- сборка `site/` → артефакт `dist/ + Dockerfile + nginx.conf`
- PR в `trunk` → деплой в staging (`~/cdkl5-staging` на VPS, https://staging.cdkl5-russia.ru, Basic Auth)
- merge в `trunk` → деплой в prod (`~/cdkl5`, https://cdkl5-russia.ru)

Контейнер — nginx, раздающий статику; проксируется swag'ом через сеть `cdkl_network`
(см. `deploy/docker-compose.*.yaml` и `deploy/nginx-staging-swag.conf`).

## Структура

```
site/
  src/
    layouts/    — Layout (head: SEO/OG, шрифты, Метрика)
    components/ — Header, Footer, Hero, ArticleCard, Toc*, Accordion, RelatedPages, CommunityBand
    pages/      — index, about-cdkl5, genetics, treatment, parents/*, 404
    content/    — HTML статей (перенесены 1:1 из старых FreeMarker-шаблонов)
    data/       — sitePages.ts (реестр страниц), aboutAccordion.json
    styles/     — global.css (токены палитры, типографика статей)
  public/       — картинки, favicon, robots.txt
deploy/         — compose-файлы staging/prod, конфиг swag
```

Исторический код на Kotlin/Ktor: тег `ktor-final` в git-истории.

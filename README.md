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

Prod VPS: `45.146.166.76`, Ubuntu 26.04.

Доступ:
- `evreke` — админ. Группы `sudo` (без пароля) и `docker`. Ключи `beget-host.pub` и `cdkl5-ci.pub`.
- `root` — только по ключу. Вход по паролю выключен для всех.
- Docker + compose установлены. Внешняя сеть `cdkl_network` создана.
- SWAG (`~/swag`) даёт TLS и реверс-прокси.

CI (`.github/workflows/test.yaml`):
- сборка `site/` → артефакт `dist/ + Dockerfile + nginx.conf`
- PR в `trunk` → деплой в staging (`~/cdkl5-staging`, https://staging.cdkl5-russia.ru, Basic Auth)
- merge в `trunk` → деплой в prod (`~/cdkl5`, https://cdkl5-russia.ru)

Контейнер — nginx, раздающий статику. SWAG проксирует его через сеть `cdkl_network`.
Файлы: `deploy/docker-compose.*.yaml`, `deploy/nginx-prod-swag.subdomain.conf`,
`deploy/nginx-staging-swag.conf`, `deploy/docker-compose.swag.yaml`.

Секреты репозитория (Settings → Secrets → Actions):

| Секрет | Значение |
|---|---|
| `SSH_PRIVATE_KEY` | приватный ключ `cdkl5-ci` (ed25519, без пароля) |
| `REMOTE_HOST` | `45.146.166.76` |
| `REMOTE_PORT` | `22` |
| `REMOTE_USER` | `evreke` |

Workflow проверяет ключ хоста по закреплённому значению `PINNED_HOST_KEY`.
Если ключ сервера меняется, обновите эту строку в workflow.

### SWAG

Первый запуск возможен только после появления DNS A-записей
(`cdkl5-russia.ru`, `www`, `staging` → IP VPS).

Имена proxy-conf должны оканчиваться на `.subdomain.conf`, иначе swag их не увидит.

```bash
cd ~/swag
echo 'SWAG_EMAIL=<email для Let'"'"'s Encrypt>' > .env
docker compose up -d
docker compose logs -f swag   # ждать выдачи сертификата
```

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

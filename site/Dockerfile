# Runtime-only: раздаёт УЖЕ СОБРАННЫЙ CI дистрибутив (dist/).
# Сборка Astro выполняется в GitHub Actions; в артефакт кладутся dist/, Dockerfile, nginx.conf.
# Локальная проверка: сначала `npm run build`, затем `docker build .`
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY dist /usr/share/nginx/html
EXPOSE 8080

# Tier 1: контейнер считается здоровым, только если nginx отвечает на /
HEALTHCHECK --interval=5s --timeout=3s --start-period=2s --retries=3 \
  CMD wget -qO/dev/null http://127.0.0.1:8080/ || exit 1

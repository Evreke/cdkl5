# Runtime-only: раздаёт УЖЕ СОБРАННЫЙ CI дистрибутив (dist/).
# Сборка Astro выполняется в GitHub Actions; в артефакт кладутся dist/, Dockerfile, nginx.conf.
# Локальная проверка: сначала `npm run build`, затем `docker build .`
#
# Ограничение nginx:alpine: модуля ngx_brotli в официальном образе НЕТ
# (проверено: `docker run --rm nginx:alpine nginx -V` -> brotli не упомянут;
# `ls /usr/lib/nginx/modules/` -> только acme/geoip/image-filter/js/xslt).
# Поэтому brotli-директивы в nginx.conf закомментированы: с этим образом они
# дадут "unknown directive" и контейнер не стартует.
# Чтобы включить Brotli, нужен base image со сборкой ngx_brotli
# (./configure --add-dynamic-module=/src/ngx_brotli) и load_module в
# main-контексте — то есть правка ЭТОГО файла (например, многоступенчатая
# сборка: alpine + сборка модуля -> COPY modules/*.so в nginx:alpine).
# Без смены образа gzip_static уже доступен (nginx -V содержит
# --with-http_gzip_static_module): прекомпрессия *.gz в CI + `gzip_static on;`.
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY dist /usr/share/nginx/html
EXPOSE 8080

# Tier 1: контейнер считается здоровым, только если nginx отвечает на /
HEALTHCHECK --interval=5s --timeout=3s --start-period=2s --retries=3 \
  CMD wget -qO/dev/null http://127.0.0.1:8080/ || exit 1

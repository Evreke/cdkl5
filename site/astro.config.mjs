import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';
import tailwindcss from '@tailwindcss/vite';

const PAGES_DIR = fileURLToPath(new URL('./src/pages', import.meta.url));

// Map a sitemap URL pathname to the source file that produced it and return
// that file's mtime. Returns undefined when no matching source file exists
// (e.g. a page added by another process) so the caller can fall back to build time.
function pageMtime(pathname) {
  const rel = pathname.replace(/^\/+|\/+$/g, '');
  const candidates =
    rel === ''
      ? ['index.astro', 'index.md', 'index.mdx', 'index.html']
      : [
          `${rel}.astro`,
          `${rel}.md`,
          `${rel}.mdx`,
          `${rel}.html`,
          `${rel}/index.astro`,
          `${rel}/index.md`,
          `${rel}/index.mdx`,
        ];
  for (const candidate of candidates) {
    try {
      const stat = fs.statSync(path.join(PAGES_DIR, candidate));
      if (stat.isFile()) return stat.mtime;
    } catch {
      // candidate does not exist -> try the next one
    }
  }
  return undefined;
}

export default defineConfig({
  site: 'https://cdkl5-russia.ru',
  integrations: [
    sitemap({
      serialize(item) {
        try {
          const lastmod = pageMtime(new URL(item.url).pathname) ?? new Date();
          return { ...item, lastmod: lastmod.toISOString() };
        } catch {
          return { ...item, lastmod: new Date().toISOString() };
        }
      },
    }),
  ],
  vite: {
    plugins: [tailwindcss()],
  },
});

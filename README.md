# Tekstura – nova spletna stran (testna različica)

Statična stran (brez gradnje): `index.html`, `config.js`, mapa `img/`.
Zavihek »Orodja in potrošni material« bere objavljene družine in artikle iz Supabase
prek funkcije `splet_katalog()` (glej `supabase/splet_katalog.sql`). Ostali zavihki so še testni.

## Objava
- GitHub: repozitorij `tekstura-splet`
- Cloudflare Pages: Framework preset **None**, Build command **prazno**, Build output directory **/**
- Vsak `git push` na `main` sproži novo objavo.

## Kaj se ureja kje
- Izdelki, slike, prevodi, objava na spletu → poslovna aplikacija (Družine izdelkov, Artikli)
- Videz in funkcije strani → ta repozitorij

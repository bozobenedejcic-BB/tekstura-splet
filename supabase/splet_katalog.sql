-- ════════════════════════════════════════════════════════════════════════════
-- JAVNI KATALOG ZA SPLETNO STRAN
-- Funkcija vrne samo družine in artikle z oznako »Objavi na spletni strani«
-- in samo javne podatke (brez nabavnih cen, popustov, zaloge, strank, dokumentov).
-- Javnost (anon) sme poklicati SAMO to funkcijo; tabele ostanejo zaprte (RLS).
-- Zaženi v Supabase → SQL Editor. Večkratni zagon je varen.
-- ════════════════════════════════════════════════════════════════════════════

create or replace function public.splet_katalog()
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(jsonb_agg(x.j order by x.kategorija, x.koda), '[]'::jsonb)
  from (
    select d.kategorija, d.koda, jsonb_build_object(
      'id', d.id,
      'proizvajalec', d.proizvajalec,
      'koda', d.koda,
      'kategorija', d.kategorija,
      'naziv', jsonb_build_object('sl', d.naziv_slo, 'en', d.naziv_eng, 'it', d.naziv_ita, 'hr', d.naziv_hrv),
      'opis',  jsonb_build_object('sl', d.opis_slo,  'en', d.opis_eng,  'it', d.opis_ita,  'hr', d.opis_hrv),
      'obdelava', d.obdelava, 'vpenjanje', d.vpenjanje, 'fiksiranje', d.fiksiranje, 'tip', d.tip,
      'material', d.material, 'stroj', d.stroj, 'proizvajalec_stroja', d.proizvajalec_stroja,
      'stolpci', d.stolpci, 'slika', d.slika_url, 'skica', d.skica_url,
      'izvedbe', (
        select coalesce(jsonb_agg(jsonb_build_object(
                 'koda', a.koda_dobavitelja,
                 'lastnosti', a.lastnosti,
                 'povprasevanje', a.splet_povprasevanje,
                 'cena_prikazana', a.splet_prikazi_ceno
               ) order by (a.lastnosti->>'premer')::numeric nulls last, a.koda_dobavitelja), '[]'::jsonb)
        from public.artikli a
        where a.druzina_id = d.id and a.splet_objavi
      )
    ) as j
    from public.druzine d
    where d.splet_objavi
      and exists (select 1 from public.artikli a where a.druzina_id = d.id and a.splet_objavi)
  ) x;
$$;

revoke all on function public.splet_katalog() from public;
grant execute on function public.splet_katalog() to anon, authenticated;

-- Preverjanje: izpiše šifre objavljenih družin in število izvedb (za PA144: 37)
select e->>'koda' as druzina, jsonb_array_length(e->'izvedbe') as izvedb
from jsonb_array_elements(public.splet_katalog()) e;

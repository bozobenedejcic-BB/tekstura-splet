// Nastavitve povezave na Supabase (enake kot v poslovni aplikaciji).
// Ta ključ je JAVEN (anon / publishable) in je namenjen brskalniku: dostop omejujejo pravila RLS
// in funkcija splet_katalog(). NIKOLI sem ne vpišite ključa »service_role« / »secret«.
window.TEKSTURA_CONFIG = {
  supabaseUrl: "https://vvddstdhvrbjjompoqps.supabase.co",
  supabaseAnonKey: "sb_publishable_oEgaeasOjBMrrci1_GvPQw_WomXPIL8"
};

# Fiamma · comandă și plată la masă prin QR

Demo pentru restaurante: fiecare masă are propriul cod QR. Clientul scanează codul, vede meniul, comandă din telefon, cheamă ospătarul cu un buton și plătește nota cu Apple Pay, Google Pay sau card, cu bacșiș, fără să aștepte.

**Demo live:** https://meniu.webwaymedia.com or https://meniuv2.webwaymedia.com

> Plățile sunt simulate. Ilustrațiile cu pizza sunt desene SVG și țin locul fotografiilor de produs.

## Variante de design

- `/`: varianta originală, italiană modernă (crem, roșu roșiatic, serif).
- `/apple/`: varianta în stil Apple. Clientul are interfață de iOS: titluri mari, liste grupate, control segmentat, foi glisante, notificări ca pe iPhone. Ospătarul are interfață de macOS, cu bară de unelte translucidă. Trece automat pe light sau dark după setarea dispozitivului.

Ambele variante folosesc același backend Supabase, deci comenzile se văd în oricare dintre ele.

## Ecrane

| Adresă | Pentru cine | Ce face |
|---|---|---|
| `#masa-1` … `#masa-12` | Client (telefon) | Meniu, coș cu observații, statusul comenzii, „Cheamă ospătarul”, nota, plată cu bacșiș sau „Cere nota” |
| `#ospatar` | Ospătar / bar (tabletă, laptop) | Mesele colorate după stare, listă „De făcut”, preluare comenzi, semnal sonor |
| `#mese` | Administrare | Coduri QR pentru fiecare masă, gata de printat |

## Cum funcționează

- Totul se află într-un singur fișier: `index.html` (HTML, CSS și JavaScript simplu, fără build).
- Starea este un jurnal de evenimente (`order`, `call`, `billReq`, `pay` etc.), combinat după id. Așa nu apar conflicte când două ecrane scriu în același timp.
- Sincronizarea între dispozitive se face prin **Supabase**: tabelul `events` plus Realtime. Comenzile se salvează pe server, nu în browser, și apar instant pe ecranul ospătarului, de pe orice telefon.
- Cheia din cod e cheia *publishable* a proiectului, publică prin design. Tabelul are RLS: oricine poate adăuga și citi evenimente, dar nimeni nu poate modifica sau șterge.
- Când nu există conexiune la Supabase (de exemplu fișierul deschis local), aplicația revine la sincronizarea între tab-urile aceluiași browser.
- Codurile QR folosesc `qrcodejs` de pe cdnjs.

## Rulare locală

Deschide `index.html` în browser, de exemplu cu `npx serve .`. Pune `#ospatar` într-un tab și `#masa-5` în altul.

## Pași spre producție

- [x] Backend real: Supabase Realtime
- [ ] Cod de masă nepredictibil și confirmarea mesei de către ospătar, ca să nu se poată comanda de acasă
- [ ] Plăți reale prin Stripe (Apple Pay și Google Pay prin Payment Request), cu firmă și cont verificat
- [ ] Bon fiscal: integrare cu casa de marcat sau cu programul de gestiune al restaurantului (de verificat cu un contabil)
- [ ] Nota împărțită, meniu editabil din panou de administrare, fotografii reale de produs
- [x] Hosting pe Cloudflare Pages (ex. `meniu.webwaymedia.com`)

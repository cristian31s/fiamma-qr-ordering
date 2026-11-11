# Fiamma · comandă și plată la masă prin QR

Demo pentru restaurante: fiecare masă are propriul cod QR. Clientul scanează codul, vede meniul, comandă din telefon, cheamă ospătarul cu un buton și plătește nota cu Apple Pay, Google Pay sau card, cu bacșiș, fără să aștepte.

**Demo live:** https://claude.ai/artifact/9qspGUkqiiys7yG4ncHJvp

> Plățile sunt simulate. Ilustrațiile cu pizza sunt desene SVG și țin locul fotografiilor de produs.

## Ecrane

| Adresă | Pentru cine | Ce face |
|---|---|---|
| `#masa-1` … `#masa-12` | Client (telefon) | Meniu, coș cu observații, statusul comenzii, „Cheamă ospătarul”, nota, plată cu bacșiș sau „Cere nota” |
| `#ospatar` | Ospătar / bar (tabletă, laptop) | Mesele colorate după stare, listă „De făcut”, preluare comenzi, semnal sonor |
| `#mese` | Administrare | Coduri QR pentru fiecare masă, gata de printat |

## Cum funcționează

- Totul se află într-un singur fișier: `index.html` (HTML, CSS și JavaScript simplu, fără build).
- Starea este un jurnal de evenimente (`order`, `call`, `billReq`, `pay` etc.), combinat după id. Așa nu apar conflicte când două ecrane scriu în același timp.
- Sincronizarea în demo:
  - prin `BroadcastChannel` între tab-urile aceluiași browser;
  - prin capabilitatea „room” a artefactului Claude între dispozitive.
- Codurile QR folosesc `qrcodejs` de pe cdnjs.

## Rulare locală

Deschide `index.html` în browser, de exemplu cu `npx serve .`. Pune `#ospatar` într-un tab și `#masa-5` în altul.

## Pași spre producție

- [ ] Backend real (Supabase Realtime sau Firebase) în locul sincronizării demo
- [ ] Cod de masă nepredictibil și confirmarea mesei de către ospătar, ca să nu se poată comanda de acasă
- [ ] Plăți reale prin Stripe (Apple Pay și Google Pay prin Payment Request), cu firmă și cont verificat
- [ ] Bon fiscal: integrare cu casa de marcat sau cu programul de gestiune al restaurantului (de verificat cu un contabil)
- [ ] Nota împărțită, meniu editabil din panou de administrare, fotografii reale de produs
- [ ] Hosting pe Cloudflare Pages (ex. `meniu.webwaymedia.com`)

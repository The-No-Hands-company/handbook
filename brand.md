# The No Hands Company Brand

How The No Hands Company looks, in one place. Everything public from TNHC — the website, the apps, the dashboard, the founder's page and the Android app — is to follow this page; until each one has been changed over, some still look different. The logo files are in [`brand/`](https://github.com/The-No-Hands-company/handbook/tree/main/brand); see [`brand/README.md`](https://github.com/The-No-Hands-company/handbook/blob/main/brand/README.md) for which file to use where. Published at https://tnhc.dev/brand.

## Logo

The logo is a warning sign: a triangle with a green rim, a black ring and a green field, and inside it a figure with its hands behind its head — look, no hands.

- **Use the files, never redraw it.** Every logo file is generated from one master drawing, `brand/logo/tnhc-sign.svg`.
- **Versions:** the full-colour sign; the sign with the name beside it (one file for dark backgrounds, one for light); a one-colour version for print and stamps; and the app icon, the sign on a black tile.
- **Clear space:** leave at least the width of the figure's head (about 11% of the sign's width) empty on every side.
- **Minimum size:** the sign 16 px wide on its own; the sign with the name 120 px wide. The 16 px browser-tab icon is the one exception, and only the triangle can be made out in it.
- **When you show TNHC's mark, never:** stretch or rotate it, change its colours beyond the versions above, put text or another picture inside the sign, add shadows, gradients or outlines, or place the full-colour sign on a green background. You may adapt the files for anything else under their licence, as long as the result is not presented as TNHC.

## Colour

Acid green, `#CCFF00`, is the TNHC colour. TNHC is dark first: void black is the default background. Every app is to offer the light mode below as well, following your device's setting; today our site and apps are dark only.

| Role | Dark (default) | Light |
|---|---|---|
| Background | `#030303` | `#F4F4F0` |
| Surface | `#0D0D0D` | `#FFFFFF` |
| Text | `#EDEDED` | `#0A0A0A` |
| Muted text | `#A8A8A8` | `#55554F` |
| Accent | `#CCFF00` — fills and text | `#CCFF00` — fills only, never text |
| On accent | `#030303` | `#0A0A0A` |

- On a light background, acid green is **never** used for text: it is unreadable (1.1:1).
- Every text colour above meets the WCAG AA contrast level (4.5:1) on its background; body text meets AAA (7:1). `scripts/check-brand.sh` checks each pair.

## Typeface

- **Figtree** for everything: headings in Bold or Black, text in Regular, the name in the logo in Black capitals.
- **JetBrains Mono** for code.
- Both are open source under the SIL Open Font License, and we serve them from our own servers, never from a font service.

## Names

- **The No Hands Company** in full the first time on a page, **TNHC** after that. Never "No Hands", "NoHands" or "The No-Hands Company".
- Our apps are called **Nexus** and a plain word: Nexus Chat, Nexus Cloud, Nexus Email. When the maker needs to be clear: "Nexus Chat, by The No Hands Company". Nexus has no logo of its own; the TNHC sign is the only mark.
- **zajfan.tnhc.dev** is the founder's page and looks like the rest of TNHC. The **Zajfan Standard** is TNHC's coding standard, named after its author.
- Our address is written **tnhc.dev**, in lower case.

## Files

| File | Use it for |
|---|---|
| `brand/logo/tnhc-sign.svg` | The sign, anywhere it has room |
| `brand/logo/tnhc-lockup-dark.svg` | The sign with the name, on dark backgrounds |
| `brand/logo/tnhc-lockup-light.svg` | The sign with the name, on light backgrounds |
| `brand/logo/tnhc-sign-mono.svg` | Print, stamps, one-colour uses |
| `brand/logo/tnhc-app-icon.svg` and `brand/icons/` | App icons, the browser tab icon, avatars |

The logo and this page are licensed [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/), like the rest of this handbook; the Charter's [name and logo policy](https://tnhc.dev/charter#our-name-and-logo) applies. The Figtree font files are under the SIL Open Font License ([`brand/fonts/OFL.txt`](https://github.com/The-No-Hands-company/handbook/blob/main/brand/fonts/OFL.txt)).

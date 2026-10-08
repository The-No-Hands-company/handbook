# The No Hands Company Charter

The No Hands Company (TNHC) offers, for free, the kind of software and services others charge for — self-hosted, federated and open to everyone.

This charter is what we promise and how we work. Every sentence in it should be true when you check it against our code. If one isn't, that is a bug: please report it.

## Our promises

- Everything we make is open source.
- Nothing is sold, and nothing is behind a paywall.
- Nothing locks you in: our software is yours to run yourself, and we are building the tools to take your data with you (see below).

### Your data

- **We never store your IP address, and we keep no logs about you.** Our services keep only what they need to work and stay secure — never for tracking, analytics or profiling. Exactly what we keep, and for how long, is listed on our [privacy status page](https://tnhc.dev/privacy).
- **An automated check proves this every day.** It sends a marked test address through every public service and searches everything we run for it. Its latest result is public on the [privacy status page](https://tnhc.dev/privacy).
- **You will be able to export all your data in open formats.** Today: Chat only.
- **Deleting your account will delete your data, everywhere.** Today: partial — see the [privacy status page](https://tnhc.dev/privacy).
- **You will be able to move your account to your own node.** Today: you can run your own node; moving an existing account is not built yet.
- **What others can see:** our web traffic passes through Cloudflare, which can see it, and mail passes through Resend and Cloudflare Email Routing. We say so plainly and are working to remove them.

We are building the Phantom Protocol to enforce this with cryptography, so that even TNHC's own infrastructure cannot see what you do. It is not finished. The [Phantom status page](https://tnhc.dev/phantom) shows exactly what works today and what does not, and we never claim more than it shows.

### Availability

TNHC's free public services run on our own hardware, on a best-effort basis. There is no uptime guarantee and no guaranteed support. If you need guarantees, run your own node or use someone else's — that is what self-hosting and federation are for.

## Ownership and licences

Nobody owns TNHC's work more than anyone else. Everything we make is licensed so that you can use it, change it and share it:

| What | Licence |
| --- | --- |
| Applications and services (the Nexus platform, our sites) | [AGPL-3.0](https://www.gnu.org/licenses/agpl-3.0.html) |
| Libraries, SDKs, protocols and the design system | [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0) |
| Documents, this handbook, and brand assets | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) |

The AGPL keeps the platform free: anyone may run a changed version, but if they offer it to others as a service, they must share their changes too. The building blocks are licensed permissively so that anyone can build on them.

### Our name and logo

You may fork, change and run anything we make, under any name you choose. You may use our name and logo to talk about TNHC — in articles and talks, or to say that something works with Nexus.

What you may not do is present something as TNHC, or as made or endorsed by TNHC, when it is not. This protects people from impostor services that could steal their accounts. It does not stop anyone from building on our work.

## Money

We do not sell anything, so the only way to give us money is a donation. We never ask for donations and nothing ever requires one. A donation buys no features, no priority and no say in decisions.

Every donation we receive and every expense we pay is published in our [finances](https://github.com/The-No-Hands-company/handbook/blob/main/finances.md).

Anyone running their own Nexus node may charge for their own hosting. Our licences allow it, and it is how federation grows.

## How we build

TNHC's software is built by AI under human direction. The people who direct it are responsible for what ships; that responsibility is never handed to the AI.

We are open about this. Our repositories say so, and our commits record when AI co-authored them. How we write code is defined in our engineering standard.

## Who decides

Today the founder, Zajfan, makes the final decisions.

That changes once TNHC has three regular contributors — people with accepted contributions in at least three of the last six months. From then on:

- Major changes are proposed in public as RFCs and discussed in the open before they are decided.
- Maintainers make the decisions within the areas they look after.
- This charter can only be changed through that same RFC process.

## Taking part

- **Report a problem**, including a promise we are not keeping: open an issue on the relevant repository at [github.com/The-No-Hands-company](https://github.com/The-No-Hands-company), or email info@tnhc.dev.
- **Suggest an idea:** open an issue. Once the RFC process exists, larger ideas go there.
- **Contribute:** open a pull request. Each project's README explains how to build and test it.

Everyone taking part follows our [Code of Conduct](https://github.com/The-No-Hands-company/handbook/blob/main/CODE_OF_CONDUCT.md).

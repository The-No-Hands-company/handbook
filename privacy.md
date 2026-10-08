# Privacy status

What TNHC promises about your data, and exactly where each promise stands today. The live result of our daily privacy check is shown at the top of [tnhc.dev/privacy](https://tnhc.dev/privacy). This page never claims more than our code does; if you find a sentence that isn't true, please [report it](https://github.com/The-No-Hands-company/handbook/issues).

## Our promises, and where they stand

| Promise | Status | How we know |
| --- | --- | --- |
| We never store your IP address | Done | A daily automated check sends a marked test address through every public service and searches everything we run for it (live result above). A check on every code change blocks code that reads visitor addresses. |
| We keep no logs about you; technical logs live at most 24 hours | Done — a few containers keep small technical logs that are continuously overwritten rather than deleted on a timer | Our log configuration is public in our repository. |
| Your sign-in history is visible only to you and deleted after 30 days | Done. Encrypted with your own key: not done yet | Your account page shows it; our sign-in service is open source. |
| Hosted sites get page-view counts only — no visitor data | Done | Our hosting service stores page, day and a count, nothing else. |
| You can export your data in open formats | Partial — Chat only | Chat's data export. |
| Deleting your account deletes your data | Partial — an administrator can delete accounts; Chat's own account deletion blanks your account but keeps your messages | — |
| You can move your account to your own node | Not done — you can already run your own node | — |
| Your stored data is encrypted with a key only you hold | Not done | Planned as part 3 of our privacy work. |

## What we keep, and why

- **Your account details** — so you can sign in.
- **Your sign-in events, for 30 days** — so you can see if someone else got into your account.
- **Your waitlist email address, until you are invited** — so we can invite you.
- **The mail, messages and files you choose to store** — that is the service.

Nothing is kept for tracking, analytics or profiling.

## What others can see

- **Cloudflare.** All web traffic to TNHC passes through Cloudflare, which decrypts it at its edge. Cloudflare can see your IP address and what you send.
- **Resend.** Mail you send to addresses outside Nexus passes through Resend.
- **Cloudflare Email Routing.** Mail sent to you from outside Nexus passes through Cloudflare first.

We state these as known limits. Our plan to remove them is onion access first, then the [Phantom Protocol](https://tnhc.dev/phantom).

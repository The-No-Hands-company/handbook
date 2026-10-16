# Privacy status

What TNHC promises about your data, and exactly where each promise stands today. The live result of our daily privacy check is shown at the top of [tnhc.dev/privacy](https://tnhc.dev/privacy). This page never claims more than our code does; if you find a sentence that isn't true, please [report it](https://github.com/The-No-Hands-company/handbook/issues).

These promises come from our [Charter](https://tnhc.dev/charter).

## Our promises, and where they stand

| Promise | Status | How we know |
| --- | --- | --- |
| We never store your IP address | Done | A daily automated check sends a marked test address to our main public services and searches our logs, containers, databases and sign-in files for it (live result above). A check on every change to our main repository — including the code of every service we run, such as Chat, Hosting and Cloud — flags code that reads visitor addresses. A daily check where any place cannot be searched, or any test request goes unanswered, counts as failed. |
| We keep no logs about you; technical logs live at most 24 hours | Partial — our own service logs are deleted within 24 hours; our containers keep small technical logs (at most 5 MB each) that are overwritten as they fill, so on a quiet service they can be older than 24 hours | Our log configuration is public in our repository. |
| Your sign-in events are shown only to you and deleted after 30 days | Done in the app: no admin screen or API shows them to anyone else. They are stored unencrypted, so whoever runs the server could read them; encrypting them with your own key is not done yet | Your account page shows them; our sign-in service is open source. |
| Hosted sites get page-view counts only — no visitor data | Done | Our hosting service stores page, day and a count, nothing else. |
| You can export your data in open formats | Partial — Chat only: your profile, servers and last 1,000 messages (not attachments) | Chat's data export. |
| Deleting your account deletes your data | Partial — an administrator can delete your sign-in account, but that does not delete what you stored in our services; Chat's own account deletion blanks your profile after 30 days but keeps your messages | — |
| You can move your account to your own node | Not done — you can already run your own node | — |
| Your stored data is encrypted with a key only you hold | Done for new Phantom messages — private keys are generated in your browser and never leave it. Existing stored data (mail, files) is not yet encrypted at rest. | Phantom key manager in Settings > Security; our sign-in service is open source. |
| We have not received any government order to disclose your data | See warrant canary below — updated at least every 90 days | [status.tnhc.dev/canary.json](https://status.tnhc.dev/canary.json) |

## What we keep, and why

- **Your account details** — so you can sign in.
- **Your sign-in events, for 30 days** — so you can see if someone else got into your account.
- **A random ID for each signed-in device, while you stay signed in** — so you can sign a device out.
- **Your waitlist email address (and the name and node you give, if any), until you are invited** — so we can invite you. It is stored at Cloudflare, not on our own hardware, and we delete it when we invite you.
- **The mail, messages and files you choose to store** — that is the service.

Nothing is kept for tracking, analytics or profiling.

## What others can see

- **Cloudflare.** All web traffic to TNHC passes through Cloudflare, which decrypts it at its edge. Cloudflare can see your IP address and what you send.
- **Cloudflare D1.** The waitlist on tnhc.dev is stored in Cloudflare's database until you are invited.
- **Resend.** Mail you send to addresses outside Nexus passes through Resend.
- **Cloudflare Email Routing.** Mail sent to you from outside Nexus passes through Cloudflare first.

We state these as known limits. Our plan to remove them is onion access first, then the [Phantom Protocol](https://tnhc.dev/phantom).

## Warrant canary

As of **2026-10-16**, TNHC states:

1. We have not received any government order, court order, subpoena, or other compulsory legal process requiring disclosure of user data.
2. We have not received any request to introduce a backdoor or surveillance capability into any TNHC system.
3. We have not been prohibited from disclosing any request for user data.

This statement is updated at least every 90 days. If it has not been updated, assume something prevents free updating and treat the canary as lapsed. The machine-readable version is at [status.tnhc.dev/canary.json](https://status.tnhc.dev/canary.json). The git history of this file is the proof of currency.

TNHC is operated in Sweden. Swedish court orders are generally public; there are no NSL-equivalent instruments under Swedish law.

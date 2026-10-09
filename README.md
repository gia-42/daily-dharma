# Daily Dharma

A daily LOST trivia quiz. Six questions a day, one for each of the Numbers. Installable as an app, playable offline, with optional accounts (email, Google, Apple) that keep streaks in sync across devices.

## What's in this folder

| File | What it does |
|---|---|
| `index.html` | The game |
| `config.js` | Your account settings. The only file you edit. |
| `manifest.webmanifest`, `sw.js`, `icons/` | Make it an installable app that works offline |
| `supabase-setup.sql` | Creates the database tables. Runs in Supabase, not on GitHub. |

Without any setup the game runs in guest mode: fully playable and installable, with stats saved per device. Accounts switch on once `config.js` is filled in.

---

## Step 1: Put it on GitHub Pages

1. In your `daily-dharma` repository, click **Add file > Upload files**.
2. Drag in everything from this folder, including the `icons` folder. Replace the old `index.html`.
3. Click **Commit changes**. The site updates in a minute or two.

Install it on a phone:
- **iPhone:** open the site in Safari, tap **Share**, then **Add to Home Screen**.
- **Android:** open it in Chrome and tap **[ INSTALL APP ]** at the bottom, or use the menu's **Install app**.

## Step 2: Create the accounts database (Supabase, free)

1. Sign up at **supabase.com** and click **New project**. Name it `daily-dharma`, set a database password (save it somewhere), and pick the **São Paulo** region. Wait a minute for it to start.
2. Open **SQL Editor**, click **New query**, paste the whole of `supabase-setup.sql`, and click **Run**. It should say "Success".
3. Open **Project Settings > API** and copy two values into `config.js`:
   - **Project URL** goes in `supabaseUrl`
   - the **anon public** key goes in `supabaseAnonKey`
4. Open **Authentication > URL Configuration**:
   - **Site URL:** `https://YOUR-USERNAME.github.io/daily-dharma/`
   - Under **Redirect URLs**, add that same address.
5. Upload the edited `config.js` to GitHub.

## Step 3: Email login (6-digit code)

1. Open **Authentication > Emails > Templates**.
2. In both the **Magic Link** and **Confirm signup** templates, add this line where you want the code to appear:
   `Your Daily Dharma code: {{ .Token }}`
3. Save both.

Supabase's built-in email sender only allows a few emails per hour. That's fine for a beta. Before a real launch, connect a free sender such as Resend under **Authentication > Emails > SMTP Settings**.

## Step 4: Google login

1. Go to **console.cloud.google.com** and create a project.
2. Set up the **OAuth consent screen**: External, app name "Daily Dharma", your email.
3. Go to **Credentials > Create credentials > OAuth client ID**, choose **Web application**.
4. Under **Authorized redirect URIs**, add `https://YOUR-PROJECT-ID.supabase.co/auth/v1/callback`. Copy the exact address from Supabase's Google provider page.
5. Copy the **Client ID** and **Client secret** into Supabase under **Authentication > Sign In / Providers > Google**, and enable it.

## Step 5: Apple login (optional)

Sign in with Apple requires a paid **Apple Developer Program** membership (US$99/year).

1. Follow Supabase's guide for the Apple provider: search "Supabase Login with Apple". It walks through the Services ID and key you create in your Apple Developer account.
2. Enable Apple in **Authentication > Sign In / Providers**.
3. In `config.js`, change `apple: false` to `apple: true` and upload it.

## Good to know

- **Installed app on iPhone:** Google and Apple sign-in hand off to Safari, so on an iPhone home-screen app the login can end up in Safari instead of the app. The email code always works inside the installed app.
- **Shipping an update:** after changing any file, open `sw.js` and bump `VERSION` (for example `dharma-v1` to `dharma-v2`), then upload. That makes installed copies pick up the new version.
- **Guest progress:** if someone plays as a guest and later logs in, that device's history is merged into their account.
- **Logging out** clears the game history stored on that device. It stays saved in the account.

# Bake Book

Sourdough orders, bake plan, payments and pantry for Phoenix sourdough. It runs as an app on your iPhone and iPad, and both devices share the same data.

All of these steps can be done on an iPad in Safari. No computer needed.

**How it fits together**

| Piece | Job | Cost |
|---|---|---|
| **Supabase** | Online database holding your orders, pantry and settings, synced between devices | Free plan |
| **GitHub** | Keeps every version of the app's files (this is what Git does), and hosts the app at a web address (GitHub Pages) | Free |
| **Your iPhone / iPad** | Opens the web address and saves it to the home screen as an app | – |

---

## 1. Create the database (Supabase)

1. Go to **supabase.com** → **Start your project** → sign up.
2. **New project**. Name: `bake-book`. Region: **Southeast Asia (Singapore)**. Set a database password and save it in your Passwords app.
3. Wait about 2 minutes for it to start.
4. Left menu → **SQL Editor** → **New query** → paste the setup code (in `supabase-setup.sql`, or ask Claude for it) → **Run**. You should see "Success. No rows returned".
5. **Authentication** → **Users** → **Add user** → **Create new user**. Your email and a password, and tick **Auto Confirm User**. This is your app login.
6. **Authentication** → **Sign In / Providers** → turn **off** "Allow new users to sign up".
7. **Project Settings** (gear) → **Data API**: copy the **Project URL**. Then **API Keys**: copy the **anon public** key (or the **publishable** key, starting `sb_publishable_`). Keep both in Notes for step 3. **Never** use the `service_role` or secret key.

## 2. Upload the app to GitHub

1. Sign up at **github.com**.
2. **+** (top right) → **New repository**. Name `bake-book`, **Public**, tick **Add a README file**. Click **Create repository**.
3. In the repo: **Add file** → **Upload files** → **choose your files** → in Files, open the unzipped `bake-book-app` folder, tap **Select**, select **all the files**, and tap **Open**.
4. At the bottom, in "Commit changes", type `First version of Bake Book` → **Commit changes**.

**What just happened (Git):** your repo is a folder that remembers every version. Each **commit** is a saved snapshot with a note. You can see them all under the clock icon ("Commits").

## 3. Connect the app to your database

1. In the repo, tap **config.js** → the **pencil** icon (Edit).
2. Replace `https://YOUR-PROJECT.supabase.co` with your Project URL, and the `PASTE-…` text with your key. Keep the quote marks.
3. **Commit changes…** → message `Connect to Supabase` → **Commit changes**.

That's your second commit. These two values are safe to have on the internet: your data is protected by your login and the security rules from step 1.4.

## 4. Turn on the web address (GitHub Pages)

1. Repo → **Settings** → **Pages**.
2. Source: **Deploy from a branch**. Branch: **main**, folder **/ (root)** → **Save**.
3. Wait 1–2 minutes and refresh. The page shows your address, for example `https://your-name.github.io/bake-book/`.

## 5. Install on iPad and iPhone

On each device:
1. Open the address in **Safari**.
2. **Share** → **Add to Home Screen** → **Add**.
3. Open Bake Book from the icon and sign in with your login from step 1.5.

## 6. Bring in your existing orders (once)

1. Save `bake-book-backup-2026-11-06.json` (sent separately) to **Files**. **Don't** upload it to GitHub: it has customer names and phone numbers.
2. Bake Book → **Recipe & prices** → **Import a backup file** → pick it → **Import now**.

---

## Changing the app later

When Claude gives you an updated file (usually `index.html`):
1. Repo → **Add file** → **Upload files** → pick the new file (it replaces the old one) → commit with a note saying what changed.
2. Also edit `sw.js` with the pencil: change `bake-book-v3` to the next number (v4, v5…), so devices fetch the new version. Commit.
3. Wait a minute, then close and reopen the app.

**Undo:** every commit is kept. Ask Claude how to go back to an earlier one.

## Good habits

- **Back up monthly:** Recipe & prices → **Save a backup file** → save to iCloud Drive.
- **Supabase pauses free projects after 7 days of no use.** Opening the app weekly keeps it awake. If it pauses, log in at supabase.com and press **Restore**. Nothing is lost.
- **Offline:** the app opens and shows your last-synced data without internet. Saving changes needs internet.

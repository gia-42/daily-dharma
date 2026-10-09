-- Daily Dharma database setup.
-- Paste this whole file into Supabase > SQL Editor > New query, then click Run. Run it once.

-- Usernames, one per account.
create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  username text not null check (username ~ '^[A-Za-z0-9_]{3,16}$'),
  created_at timestamptz not null default now()
);
-- Usernames are unique regardless of upper/lower case.
create unique index if not exists profiles_username_unique on public.profiles (lower(username));

-- One row per player per day.
create table if not exists public.results (
  user_id uuid not null references auth.users (id) on delete cascade,
  day date not null,
  picks smallint[] not null default '{}',
  score smallint not null default 0 check (score between 0 and 6),
  done boolean not null default false,
  updated_at timestamptz not null default now(),
  primary key (user_id, day)
);

-- Security: each player can only read and change their own data.
-- (Logged-in players can see usernames, which the friends feature will need later.)
alter table public.profiles enable row level security;
alter table public.results enable row level security;

drop policy if exists "profiles readable by players" on public.profiles;
create policy "profiles readable by players" on public.profiles
  for select to authenticated using (true);

drop policy if exists "players create own profile" on public.profiles;
create policy "players create own profile" on public.profiles
  for insert to authenticated with check (auth.uid() = id);

drop policy if exists "players update own profile" on public.profiles;
create policy "players update own profile" on public.profiles
  for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);

drop policy if exists "players read own results" on public.results;
create policy "players read own results" on public.results
  for select to authenticated using (auth.uid() = user_id);

drop policy if exists "players add own results" on public.results;
create policy "players add own results" on public.results
  for insert to authenticated with check (auth.uid() = user_id);

drop policy if exists "players update own results" on public.results;
create policy "players update own results" on public.results
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

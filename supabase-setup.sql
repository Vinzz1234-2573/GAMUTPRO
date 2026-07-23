-- Run this once in your Supabase project's SQL Editor (Project → SQL Editor → New query → Run).
-- Creates the jobs table and locks it down so:
--   - anyone can VIEW postings (needed for the public careers page)
--   - only a logged-in admin can ADD / EDIT / DELETE postings

create table public.jobs (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  location text not null,
  job_type text not null,
  salary_range text,
  classification text,
  summary text not null,
  created_at timestamptz not null default now()
);

alter table public.jobs enable row level security;

create policy "Public can read jobs"
  on public.jobs for select
  to anon, authenticated
  using (true);

create policy "Authenticated users can insert jobs"
  on public.jobs for insert
  to authenticated
  with check (true);

create policy "Authenticated users can update jobs"
  on public.jobs for update
  to authenticated
  using (true);

create policy "Authenticated users can delete jobs"
  on public.jobs for delete
  to authenticated
  using (true);

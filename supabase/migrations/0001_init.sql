create table if not exists projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  location text,
  area_description text,
  local_regulations_ref text,
  created_at timestamptz not null default now()
);

create table if not exists documents (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  project_id uuid references projects(id) on delete cascade,
  contractor_name text not null,
  document_title text not null,
  document_type text default 'method_statement',
  file_url text,
  status text default 'submitted',
  submitted_at timestamptz default now(),
  created_at timestamptz not null default now()
);

create table if not exists reviews (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  document_id uuid references documents(id) on delete cascade,
  status text default 'draft',
  reviewer_name text,
  started_at timestamptz,
  completed_at timestamptz,
  overall_assessment text,
  created_at timestamptz not null default now()
);

create table if not exists comments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  review_id uuid references reviews(id) on delete cascade,
  section_reference text,
  comment_text text not null,
  category text default 'needs_improvement',
  severity text default 'minor',
  recommendation text,
  standard_id uuid,
  ai_generated boolean default false,
  ai_source text,
  ai_confidence numeric,
  review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);

create table if not exists standards (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  jurisdiction text,
  standard_type text,
  reference_code text,
  description text,
  created_at timestamptz not null default now()
);

alter table projects enable row level security;
alter table documents enable row level security;
alter table reviews enable row level security;
alter table comments enable row level security;
alter table standards enable row level security;

drop policy if exists "projects_v1_read" on projects;
create policy "projects_v1_read" on projects for select using (true);
drop policy if exists "projects_v1_write" on projects;
create policy "projects_v1_write" on projects for all using (true) with check (true);

drop policy if exists "documents_v1_read" on documents;
create policy "documents_v1_read" on documents for select using (true);
drop policy if exists "documents_v1_write" on documents;
create policy "documents_v1_write" on documents for all using (true) with check (true);

drop policy if exists "reviews_v1_read" on reviews;
create policy "reviews_v1_read" on reviews for select using (true);
drop policy if exists "reviews_v1_write" on reviews;
create policy "reviews_v1_write" on reviews for all using (true) with check (true);

drop policy if exists "comments_v1_read" on comments;
create policy "comments_v1_read" on comments for select using (true);
drop policy if exists "comments_v1_write" on comments;
create policy "comments_v1_write" on comments for all using (true) with check (true);

drop policy if exists "standards_v1_read" on standards;
create policy "standards_v1_read" on standards for select using (true);
drop policy if exists "standards_v1_write" on standards;
create policy "standards_v1_write" on standards for all using (true) with check (true);

insert into projects (id, name, location, area_description, local_regulations_ref) values
('a0000000-0000-0000-0000-000000000001', 'Offshore Platform Alpha', 'Caspian Sea, Block X', 'Well intervention and maintenance operations on fixed platform', 'Petroleum Regulations 2018, Environmental Protection Act'),
('a0000000-0000-0000-0000-000000000002', 'Onshore Gas Processing Plant', 'Desert Region, Sector 7', 'Gas compression, processing and export pipeline tie-in', 'Oil & Gas Safety Code 2020, HSE Ministry Directive 14'),
('a0000000-0000-0000-0000-000000000003', 'Refinery Turnaround Project', 'Coastal Industrial Zone', 'Planned shutdown maintenance of distillation unit and associated pipework', 'Refinery Safety Standards 2019, EPA Discharge Rules')
on conflict (id) do nothing;

insert into standards (id, name, jurisdiction, standard_type, reference_code, description) values
('b0000000-0000-0000-0000-000000000001', 'IOGP Report 459', 'international', 'standard', 'IOGP 459', 'Consequence assessment methodologies and risk tolerability criteria for upstream oil and gas operations'),
('b0000000-0000-0000-0000-000000000002', 'ISO 45001', 'international', 'standard', 'ISO 45001:2018', 'Occupational health and safety management systems — requirements with guidance for use'),
('b0000000-0000-0000-0000-000000000003', 'Petroleum Regulations 2018', 'local', 'regulation', 'PR-2018', 'National petroleum operations safety and environmental regulations'),
('b0000000-0000-0000-0000-000000000004', 'H2S Exposure Limits', 'industry', 'guideline', 'API RP 55', 'Recommended practices for oil and gas producing and gas processing plant operations involving H2S')
on conflict (id) do nothing;

insert into documents (id, project_id, contractor_name, document_title, document_type, file_url, status, submitted_at) values
('c0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000001', 'DeepTech Engineering', 'HSE Method Statement — Well Intervention', 'method_statement', 'https://example.com/docs/well-intervention-hse.pdf', 'under_review', '2024-01-15T09:00:00Z'),
('c0000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000001', 'MarineTech Services', 'Environmental Impact Procedure — Platform Alpha', 'procedure', 'https://example.com/docs/env-impact-platform-alpha.pdf', 'submitted', '2024-02-01T10:00:00Z'),
('c0000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000002', 'GasFlow Contractors', 'Gas Processing Safety Plan — Sector 7', 'plan', 'https://example.com/docs/gas-safety-sector7.pdf', 'reviewed', '2024-01-20T14:00:00Z'),
('c0000000-0000-0000-0000-000000000004', 'a0000000-0000-0000-0000-000000000003', 'Turnaround Specialists Ltd', 'Turnaround HSE Plan — Distillation Unit', 'plan', 'https://example.com/docs/turnaround-hse-distillation.pdf', 'submitted', '2024-02-10T08:00:00Z')
on conflict (id) do nothing;

insert into reviews (id, document_id, status, reviewer_name, started_at, completed_at, overall_assessment) values
('d0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000001', 'in_progress', 'Sarah Chen', '2024-01-16T08:00:00Z', null, null),
('d0000000-0000-0000-0000-000000000002', 'c0000000-0000-0000-0000-000000000003', 'completed', 'Ahmed Hassan', '2024-01-21T09:00:00Z', '2024-01-25T16:00:00Z', 'Document addresses most HSE concerns but requires improvement in emergency response procedures and H2S handling protocols.'),
('d0000000-0000-0000-0000-000000000003', 'c0000000-0000-0000-0000-000000000002', 'draft', 'Sarah Chen', null, null, null)
on conflict (id) do nothing;

insert into comments (id, review_id, section_reference, comment_text, category, severity, recommendation, standard_id, ai_generated, ai_source, ai_confidence, review_status) values
('e0000000-0000-0000-0000-000000000001', 'd0000000-0000-0000-0000-000000000001', '3.2 Emergency Response', 'Emergency response procedure does not specify evacuation routes for the platform deck areas. Add site-specific evacuation maps and muster point locations.', 'missing', 'critical', 'Include platform-specific evacuation route maps and designate muster points per deck level.', 'b0000000-0000-0000-0000-000000000001', false, null, null, 'approved'),
('e0000000-0000-0000-0000-000000000002', 'd0000000-0000-0000-0000-000000000001', '4.1 PPE Requirements', 'PPE list is generic. Does not address H2S-specific respiratory protection requirements for well intervention activities.', 'needs_improvement', 'major', 'Add H2S monitoring and respiratory protection requirements referencing API RP 55 and local regulations.', 'b0000000-0000-0000-0000-000000000004', false, null, null, 'approved'),
('e0000000-0000-0000-0000-000000000003', 'd0000000-0000-0000-0000-000000000001', '5.0 Environmental Protection', 'No mention of spill containment measures for chemical handling areas. Add secondary containment requirements and spill response kit locations.', 'missing', 'major', 'Specify secondary containment for all chemical storage and handling areas with spill kit placement plan.', 'b0000000-0000-0000-0000-000000000003', true, 'openai-gpt-4o', 0.85, 'unreviewed'),
('e0000000-0000-0000-0000-000000000004', 'd0000000-0000-0000-0000-000000000002', '2.1 Risk Assessment', 'Risk assessment matrix is comprehensive and aligns with ISO 45001 requirements. Adequate hazard identification methodology.', 'adequate', 'minor', null, 'b0000000-0000-0000-0000-000000000002', false, null, null, 'approved'),
('e0000000-0000-0000-0000-000000000005', 'd0000000-0000-0000-0000-000000000002', '6.3 H2S Management', 'H2S exposure limits do not match local Petroleum Regulations 2018. Document cites 15 ppm STEL but local regulation requires 10 ppm.', 'non_compliant', 'critical', 'Revise H2S STEL to 10 ppm per Petroleum Regulations 2018, Section 24.3.', 'b0000000-0000-0000-0000-000000000003', false, null, null, 'approved'),
('e0000000-0000-0000-0000-000000000006', 'd0000000-0000-0000-0000-000000000002', '7.0 Waste Management', 'Waste management section lacks categorization of hazardous vs non-hazardous waste streams. Add waste classification and disposal chain of custody.', 'needs_improvement', 'major', 'Include waste classification matrix and disposal documentation requirements per EPA Discharge Rules.', null, true, 'openai-gpt-4o', 0.78, 'approved')
on conflict (id) do nothing;
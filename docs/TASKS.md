# Tasks

## Sprint 1: Foundation & Documents
**Goal**: App shell, DB schema, project + document CRUD with seed data
- [ ] Set up Next.js + Supabase project, run migration SQL
- [ ] Build responsive sidebar nav (Projects, Documents, Reviews, Standards)
- [ ] Projects: list, create, detail
- [ ] Documents: list per project, upload (file URL), detail
- [ ] Seed demo data (3 projects, 4 documents, 4 standards)
- [ ] Empty + loading states for all list views
**DoD**: Can create a project, upload a document, and view both — no login required.

## Sprint 2: Reviews & Comments (CORE ENGINE) ← v1 functional milestone
**Goal**: Full review → comment → issue flow working end-to-end
- [ ] Reviews: create (start review), list, detail
- [ ] Comments: add, edit, delete within a review
- [ ] Comment fields: section_reference, comment_text, category, severity, recommendation
- [ ] Review status transitions: draft → in_progress → completed
- [ ] "Issued comment set" view when review completed
- [ ] Empty + error states for reviews and comments
**DoD**: Reviewer creates a review on a document, adds comments, marks complete, and views the full issued comment set — all persisted. **← v1 functional**

## Sprint 3: AI Review Assistant
**Goal**: AI drafts comments; reviewer approves/edits/rejects
- [ ] `lib/ai/review-assistant.ts` — analyze document text, suggest comments
- [ ] "Draft with AI" button on review page
- [ ] AI comments stored with ai_source, ai_confidence, review_status = 'unreviewed'
- [ ] Approve / edit / reject AI comment actions
- [ ] Confidence < 0.6 flagged for manual attention
- [ ] AI unavailable → graceful fallback (manual only)
**DoD**: AI suggests comments on a document; reviewer approves/edits/rejects; approved comments appear in issued set.

## Sprint 4: Standards Library
**Goal**: Manage reference standards, link comments to standards
- [ ] Standards: list, create, edit, detail
- [ ] Link comment to standard_id
- [ ] Filter comments by standard within a review
- [ ] `suggest_standard_link` tool (AI recommends matching standard)
**DoD**: Can browse standards, link a comment to a specific standard, filter comments by standard.

## Sprint 5: Dashboard & Export
**Goal**: Review status overview, comment statistics, export
- [ ] Dashboard: active reviews, completed reviews, comment stats by severity
- [ ] Document risk score (rule-based)
- [ ] Export completed review as PDF (issued comment set)
- [ ] Filter/sort reviews by status, project, date
**DoD**: Dashboard shows review stats; can export a completed review as a structured PDF.

## Sprint 6: Lock It Down
**Goal**: Auth, per-user RLS, audit logging — remove demo open access
- [ ] Supabase Auth: login/signup for review staff
- [ ] RLS: replace permissive policies with `auth.uid() = user_id` on all tables
- [ ] audit_logs table + logging on all meaningful actions
- [ ] Remove or mark demo seed data as system-owned
- [ ] Redirect unauthenticated users to login
**DoD**: Anonymous access removed; only logged-in users see their own data; all actions audited.

## Gantt
```
S1: Foundation & Documents      ████████
S2: Reviews & Comments (v1)    ████████  ← v1 functional
S3: AI Review Assistant         ████████
S4: Standards Library          ████████
S5: Dashboard & Export         ████████
S6: Lock It Down              ████████
```
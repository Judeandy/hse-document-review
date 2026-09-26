# Architecture

## Stack
Next.js 14 (App Router) + Tailwind | Supabase (Postgres, RLS, Storage) | Vercel | OpenAI API

## Build Sequence
- **Now**: Upload docs → start review → add comments → issue review
- **Next**: AI comment drafting → standards library → export
- **Later**: Teams, dashboards, contractor responses

## Key Action Flow
1. Reviewer opens project, uploads contractor HSE document
2. "Start Review" → review created (status: in_progress)
3. Add comments: section ref, issue, category, severity, recommendation
4. (Optional) "Draft with AI" → suggests comments with confidence + review_status
5. Approve/edit/reject AI comments
6. Mark complete → full issued comment set viewable

## Navigation
Left sidebar (Projects, Documents, Reviews, Standards) on desktop; hamburger on mobile. Current section highlighted.

## Layers
1. **Data** (`lib/data/`): all DB reads/writes — single access point
2. **Actions** (`lib/actions/`): server-side create/issue logic
3. **AI** (`lib/ai/`): document analysis, comment drafting — isolated, optional
4. **UI** (`app/`, `components/`): screens and shared components

Core review flow is pure CRUD. AI only drafts suggestions; reviews complete without it.

## Repo Structure
```
app/ layout.tsx, page.tsx, projects/, documents/, reviews/, standards/
components/ CommentCard, DocumentUploader, StatusBadge, etc.
lib/data/ projects.ts, documents.ts, reviews.ts, comments.ts, standards.ts
lib/actions/ reviews.ts, comments.ts
lib/ai/ review-assistant.ts
__tests__/
```

## Module Map
| Module | Responsibility | Owns | Order |
|---|---|---|---|
| Documents | Upload & manage contractor documents | documents, projects | 1st |
| Reviews | Create & manage review sessions | reviews | 2nd |
| Comments | Create, edit, approve, issue comments | comments | 3rd (core engine) |
| Standards | Reference standards library | standards | 4th |
| AI Review | AI-drafted comments & analysis | ai fields on comments | 5th |
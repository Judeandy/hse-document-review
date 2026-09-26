# Test Plan

## v1 Success Scenario
1. Open app (no login) → dashboard shows seeded projects
2. Click a project → see its documents
3. Upload a new document or open seeded one → document detail page
4. Click "Start Review" → review created with status "in_progress"
5. Add a manual comment: section "4.1 Fire Safety", issue text, category "needs_improvement", severity "major", recommendation
6. Click "Draft with AI" → AI suggests 2–3 comments with confidence scores, status "unreviewed"
7. Approve one AI comment, edit another, reject one
8. Mark review "completed" → view full issued comment set
9. Refresh page → all comments and review status persist

## Empty States
- No projects: "Create your first project" CTA
- No documents in project: "Upload a contractor document" CTA
- No comments in review: "Add a comment or draft with AI" CTA
- No reviews: "Start a review" CTA

## Error States
- File upload fails: error message + retry option
- AI service unavailable: "AI drafting unavailable — add comments manually" banner; review still functional
- DB write fails: error toast; form retains input
- Loading: skeleton loaders for lists, spinner for AI drafting

## Data Integrity
- Delete a comment → removed from review; comment count updates
- Delete a project → cascade deletes documents, reviews, comments
- Refresh after any action → state persists (server-derived)
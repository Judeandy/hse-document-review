# Agentic Layer

## Draftable Actions (low risk — auto)
- Draft review comments from document text → stored with review_status = 'unreviewed'
- Suggest category + severity for a given section
- Summarize document sections for reviewer context
- Score document risk from comment severities

## Executable After Approval (medium risk)
- Update review status (draft → in_progress → completed) — reviewer confirms
- Approve AI-drafted comment → review_status = 'approved'
- Edit AI-drafted comment text before approval
- Link comment to a specific standard

## Human-Only Actions (critical)
- Delete a comment permanently
- Delete a review
- Reject all AI comments (bulk)
- Export/issue final review to external system

## Named Tools
- `analyze_document` — reads document text, returns structured comment suggestions
- `draft_comment` — drafts a single comment for a given section
- `score_review` — calculates risk score from comment severities
- `suggest_standard_link` — recommends matching standard for a comment

## Audit Log Fields
action · actor (user_id) · target_table · target_id · metadata (jsonb) · created_at

## v1 vs Later
- **v1**: Draft + approve/reject AI comments, manual comment CRUD
- **Later**: Auto-issue reviews, bulk AI processing, scheduled review reminders
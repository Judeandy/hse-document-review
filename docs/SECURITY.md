# Security

## Secret Handling
- OpenAI API key stored as Vercel env var / Supabase secret — never in frontend code or client bundles
- Supabase service role key used only in server actions / edge functions
- No secrets in `NEXT_PUBLIC_*` vars

## Permission Model (End State — after lock-down sprint)
- Every table has `user_id`; RLS policies enforce `auth.uid() = user_id` for all reads/writes
- v1: permissive policies for demo (no login required); replaced at lock-down
- Agent inherits the logged-in reviewer's permissions — can only read/write rows the user owns

## Approved Tools Rule
- AI can only call named, pre-approved tools (`analyze_document`, `draft_comment`, `score_review`, `suggest_standard_link`)
- No raw tool execution, no arbitrary SQL, no `run_any`/`send_any`
- All tool calls are server-side only

## Audit Principle
- Every meaningful action logged: create/edit/delete comment, approve/reject AI comment, change review status, issue review
- Audit entries are append-only, stored server-side
- Logs survive refresh and are identical across devices (server-derived, not localStorage)
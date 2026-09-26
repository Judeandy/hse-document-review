# Data Model

## projects
- id: uuid (PK) · user_id: uuid (nullable) · name: text · location: text · area_description: text · local_regulations_ref: text · created_at: timestamptz
- **RLS**: v1 permissive; later owner-scoped (auth.uid() = user_id)

## documents
- id: uuid (PK) · user_id: uuid (nullable) · project_id: uuid (FK→projects) · contractor_name: text · document_title: text · document_type: text (method_statement | procedure | plan | other) · file_url: text · status: text (submitted | under_review | reviewed) · submitted_at: timestamptz · created_at: timestamptz
- **RLS**: v1 permissive; later owner-scoped

## reviews
- id: uuid (PK) · user_id: uuid (nullable) · document_id: uuid (FK→documents) · status: text (draft | in_progress | completed) · reviewer_name: text · started_at: timestamptz · completed_at: timestamptz · overall_assessment: text · created_at: timestamptz
- **RLS**: v1 permissive; later owner-scoped

## comments
- id: uuid (PK) · user_id: uuid (nullable) · review_id: uuid (FK→reviews) · section_reference: text · comment_text: text (value — may be AI-generated) · category: text (adequate | needs_improvement | missing | non_compliant) · severity: text (critical | major | minor) · recommendation: text · standard_id: uuid (FK→standards, nullable) · ai_generated: boolean default false · ai_source: text (nullable — model/origin) · ai_confidence: numeric (nullable — 0–1) · review_status: text default 'unreviewed' (unreviewed | approved | rejected) · created_at: timestamptz
- **RLS**: v1 permissive; later owner-scoped
- **AI fields**: comment_text, category, severity, recommendation can be AI-drafted → tracked via ai_generated + ai_source + ai_confidence + review_status

## standards
- id: uuid (PK) · user_id: uuid (nullable) · name: text · jurisdiction: text (local | international | industry) · standard_type: text (regulation | standard | guideline) · reference_code: text · description: text · created_at: timestamptz
- **RLS**: v1 permissive; later owner-scoped

## Relationships
- projects 1—N documents · documents 1—N reviews · reviews 1—N comments · standards 1—N comments (optional)
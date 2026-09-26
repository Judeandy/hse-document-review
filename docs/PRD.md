# HSE Document Review

## Problem
Contractors submit HSE documents (method statements, procedures, plans) for oil & gas projects. Review staff must check each document against local regulations, international standards, and project-specific HSE requirements — then issue structured comments to improve compliance. Today this is manual, inconsistent, and slow.

## Target User
HSE review staff at an oil & gas operator or consultancy. They receive contractor documents, review them, and return actionable improvement comments.

## Core Objects
- **Project** — site/area context with applicable regulations
- **Document** — contractor-submitted HSE document (method statement, procedure, plan)
- **Review** — a review session on a document, tracking status and reviewer
- **Comment** — structured review comment: section reference, issue, category, severity, recommendation
- **Standard** — reference standard (local regulation, international, industry practice)

## MVP (v1) — must-haves
- [ ] Create projects with site context and applicable regulations
- [ ] Upload/list contractor documents per project
- [ ] Start a review on a document
- [ ] Add, edit, delete review comments (manual)
- [ ] Categorize comments (adequate / needs improvement / missing / non-compliant) and severity (critical / major / minor)
- [ ] Mark review complete and view the full issued comment set
- [ ] AI-assisted: draft comments by analyzing document text against standards (with confidence + review_status)
- [ ] Responsive sidebar navigation

## Non-goals (v1)
- Multi-user teams / role-based permissions
- Contractor portal / response tracking
- Automated regulatory compliance scoring dashboards
- Email notifications
- Document version control

## Success Criteria
A reviewer uploads a contractor's HSE method statement, starts a review, adds both manual and AI-suggested comments referencing specific sections and standards, marks the review complete, and views the full structured issued comment set — all without logging in (demo mode).
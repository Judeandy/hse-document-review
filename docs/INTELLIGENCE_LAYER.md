# Intelligence Layer

## Messy Inputs
- Contractor documents: PDFs with varying structure, headings, formatting
- Free-text reviewer notes added during review
- Project context: location, applicable regulations

## Auto-Structure Schema
AI analyzes a document and outputs structured comments:
```json
{
  "comments": [
    {
      "section_reference": "4.2 PPE Requirements",
      "comment_text": "Section does not specify respiratory protection for H2S exposure areas. Add requirement for H2S monitors and respirators.",
      "category": "missing",
      "severity": "critical",
      "recommendation": "Add H2S PPE section referencing local regulation PR-2018 and API RP 55.",
      "standard_id": "<uuid>",
      "ai_confidence": 0.88,
      "review_status": "unreviewed"
    }
  ]
}
```

## Events to Track
review_started · comment_added (manual) · ai_comment_drafted · comment_approved · comment_rejected · comment_edited · review_completed · document_uploaded

## Scoring Rules (v1, rule-based)
- **Document risk score**: sum of severity weights (critical=3, major=2, minor=1) across all comments
- **Review completeness**: comments covering distinct sections / total document sections
- **AI confidence flag**: < 0.6 highlighted for manual attention
- **Compliance ratio**: adequate comments / total comments (excluding missing/non-compliant)

## What Gets Ranked
- Comments by severity (critical first) within a review
- Documents by risk score across a project

## v1 vs Later
- **v1**: AI drafts comments, rule-based severity ranking, confidence flagging
- **Later**: Pattern detection across documents, automated compliance scoring, historical trend analysis
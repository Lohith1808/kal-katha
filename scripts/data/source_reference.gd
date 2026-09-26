class_name SourceReference
extends Resource

## Data contract for verified source citations.
## Enforces AGENTS.md Rule 10:
## "Every historical chapter should support source references."
##
## All events, figures, and settings must tie back to documented academic or archival citations.

@export var citation_id: String = ""
@export var title: String = ""
@export var author: String = ""
@export var publication_or_archive: String = ""
@export var citation_details: String = ""

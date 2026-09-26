class_name HistoricalChapter
extends Resource

## Data contract for a historical chapter.
## Enforces AGENTS.md Rules 3, 8, 9, 10:
## Historical content remains strictly separate from gameplay code.
##
## This resource is a structural schema only.
## Content instances must come strictly from verified project content records.

@export var chapter_id: String = ""
@export var era: HistoricalEra.Type = HistoricalEra.Type.ANCIENT
@export var title: String = ""
@export var historical_timeframe: String = ""
@export var sources: Array[SourceReference] = []
@export var checkpoint_ids: Array[String] = []

class_name HistoricalEra
extends RefCounted

## Canonical historical era categories for Kal Katha.
## Enforces AGENTS.md Rule 9:
## "Ancient, Medieval and Modern history must remain separately categorized."

enum Type {
	ANCIENT,
	MEDIEVAL,
	MODERN
}

static func to_string_name(era_type: Type) -> String:
	match era_type:
		Type.ANCIENT:
			return "Ancient"
		Type.MEDIEVAL:
			return "Medieval"
		Type.MODERN:
			return "Modern"
		_:
			return "Unknown"

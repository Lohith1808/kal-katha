class_name SaveManager
extends RefCounted

## Local save and progression manager for Kal Katha.
## Stores player progress flags, settings, and checkpoint markers in user:// storage.
##
## Complies with AGENTS.md:
## - Rule 1 & 4: Never stores invented historical facts or altered timelines.
## - Rule 7: Stores checkpoint markers for deterministic retry/reset.

const SAVE_FILE_PATH: String = "user://save_data.json"

static func get_default_save_data() -> Dictionary:
	return {
		"version": 1,
		"current_checkpoint_id": "",
		"completed_chapter_ids": [],
		"unlocked_citation_ids": [],
		"settings": {
			"master_volume": 1.0,
			"music_volume": 0.8,
			"sfx_volume": 0.8
		}
	}

static func save_game(data: Dictionary) -> bool:
	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("[SaveManager] Failed to open save file for writing: " + str(FileAccess.get_open_error()))
		return false
	
	var json_string := JSON.stringify(data, "  ")
	file.store_string(json_string)
	file.close()
	return true

static func load_game() -> Dictionary:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return get_default_save_data()
	
	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if file == null:
		push_warning("[SaveManager] Could not open save file for reading, returning defaults.")
		return get_default_save_data()
	
	var content := file.get_as_text()
	file.close()
	
	var parsed = JSON.parse_string(content)
	if typeof(parsed) != TYPE_DICTIONARY:
		push_warning("[SaveManager] Save file format invalid or corrupt, returning defaults.")
		return get_default_save_data()
	
	return parsed

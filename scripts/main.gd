class_name Main
extends Control

## Entry point for the Kal Katha project foundation.
## Initializes core systems and validates that project systems are ready.

@onready var status_label: Label = $StatusLabel

func _ready() -> void:
	print("[Kal Katha] Project foundation initialized.")
	
	# Validate local save storage accessibility
	var save_data: Dictionary = SaveManager.load_game()
	print("[Kal Katha] Save profile ready (Version: %s)." % str(save_data.get("version", 1)))
	
	if status_label:
		status_label.text = "Kal Katha\nFoundation Initialized"

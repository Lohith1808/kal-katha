class_name HomeScreen
extends Control

const SaveManager = preload("res://scripts/core/save_manager.gd")
const HistoricalMenuButton = preload("res://scripts/ui/components/historical_menu_button.gd")

## Main Home Screen for Kal Katha.
## Implements a restrained, historical 2D game interface.
##
## Complies with AGENTS.md:
## - Rule 1 & 3: Never authors or invents historical claims.
## - Rule 7: Failure returns to checkpoint; Continue checks for verified checkpoints.
## - Rule 8: Keeps historical content separate from UI code.

@onready var continue_button: HistoricalMenuButton = %ContinueButton
@onready var new_journey_button: HistoricalMenuButton = %NewJourneyButton
@onready var chapters_button: HistoricalMenuButton = %ChaptersButton
@onready var historical_record_button: HistoricalMenuButton = %HistoricalRecordButton
@onready var settings_button: HistoricalMenuButton = %SettingsButton

@onready var save_status_label: Label = %SaveStatusLabel
@onready var version_label: Label = %VersionLabel

# Right Showcase Area nodes
@onready var default_showcase: Control = %DefaultShowcase
@onready var info_drawer: PanelContainer = %InfoDrawer
@onready var drawer_category_label: Label = %DrawerCategoryLabel
@onready var drawer_title_label: Label = %DrawerTitleLabel
@onready var drawer_body_label: Label = %DrawerBodyLabel
@onready var drawer_dismiss_button: Button = %DrawerDismissButton

var _save_data: Dictionary = {}
var _drawer_tween: Tween

func _ready() -> void:
	_setup_version_and_save_state()
	_connect_menu_buttons()
	_show_default_showcase(true)
	print("[HomeScreen] Initialized successfully. " + save_status_label.text)

func _setup_version_and_save_state() -> void:
	version_label.text = "Kal Katha • Prototype v0.1.0"
	
	# Query existing SaveManager without altering save state
	_save_data = SaveManager.load_game()
	var current_checkpoint: String = str(_save_data.get("current_checkpoint_id", ""))
	
	if current_checkpoint.strip_edges() != "":
		continue_button.button_title = "CONTINUE"
		continue_button.set_locked_state(false)
		continue_button.tooltip_text = "Resume journey from checkpoint: " + current_checkpoint
		save_status_label.text = "Recorded Journey: Checkpoint " + current_checkpoint
	else:
		continue_button.button_title = "CONTINUE"
		continue_button.set_locked_state(true, "No Save")
		continue_button.tooltip_text = "No saved journey found. Select 'New Journey' to begin."
		save_status_label.text = "Journey Status: No active journey"

func _connect_menu_buttons() -> void:
	continue_button.button_activated.connect(_on_menu_button_activated)
	new_journey_button.button_activated.connect(_on_menu_button_activated)
	chapters_button.button_activated.connect(_on_menu_button_activated)
	historical_record_button.button_activated.connect(_on_menu_button_activated)
	settings_button.button_activated.connect(_on_menu_button_activated)
	
	if drawer_dismiss_button:
		drawer_dismiss_button.pressed.connect(_on_drawer_dismiss_pressed)

func _on_menu_button_activated(action_id: String) -> void:
	match action_id:
		"continue":
			var current_checkpoint: String = str(_save_data.get("current_checkpoint_id", ""))
			if current_checkpoint != "":
				_show_info_drawer(
					"CHECKPOINT RECOVERY",
					"CONTINUE JOURNEY",
					"Active checkpoint identified: '%s'.\n\nIn compliance with AGENTS.md Rule 7, resuming will return cleanly to this checkpoint. Full chapter scene loading will be linked in the vertical slice phase." % current_checkpoint
				)
			else:
				_show_info_drawer(
					"NOTICE",
					"NO SAVED JOURNEY",
					"No historical journey checkpoint has been recorded yet.\n\nChoose 'New Journey' to start from the initial chapter milestone."
				)
		
		"new_journey":
			_show_info_drawer(
				"JOURNEY INITIALIZATION",
				"START A NEW JOURNEY",
				"The journey initialization framework is ready.\n\nOnce the first verified historical chapter dossier is approved, starting a new journey will load that chapter's opening sequence."
			)
		
		"chapters":
			_show_info_drawer(
				"COMING SOON",
				"HISTORICAL CHAPTERS",
				"Historical chapters are currently undergoing archival source verification.\n\nIn compliance with AGENTS.md Rule 3 and Rule 9, chapters across Ancient, Medieval, and Modern history will unlock as verified dossiers are approved."
			)
		
		"historical_record":
			_show_info_drawer(
				"COMING SOON",
				"HISTORICAL RECORD & CODEX",
				"The Historical Record will serve as the game's archival reference library.\n\nIn compliance with AGENTS.md Rule 10, every historical chapter will link to authenticated source citations and primary documents here."
			)
		
		"settings":
			_show_info_drawer(
				"PROTOTYPE STATUS",
				"GAME SETTINGS",
				"Local configuration storage is initialized in user://save_data.json.\n\nMaster, music, and sound effect volume controls will be connected to audio buses in the next implementation milestone."
			)

func _show_info_drawer(category: String, title: String, body: String) -> void:
	drawer_category_label.text = category
	drawer_title_label.text = title
	drawer_body_label.text = body
	
	default_showcase.visible = false
	info_drawer.visible = true
	info_drawer.modulate.a = 0.0
	
	if _drawer_tween and _drawer_tween.is_running():
		_drawer_tween.kill()
	
	_drawer_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	_drawer_tween.tween_property(info_drawer, "modulate:a", 1.0, 0.18)

func _on_drawer_dismiss_pressed() -> void:
	_show_default_showcase(false)

func _show_default_showcase(immediate: bool) -> void:
	if immediate:
		info_drawer.visible = false
		default_showcase.visible = true
		default_showcase.modulate.a = 1.0
		return
	
	if _drawer_tween and _drawer_tween.is_running():
		_drawer_tween.kill()
	
	_drawer_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	_drawer_tween.tween_property(info_drawer, "modulate:a", 0.0, 0.12)
	_drawer_tween.tween_callback(func():
		info_drawer.visible = false
		default_showcase.visible = true
		default_showcase.modulate.a = 0.0
		var fade_in := create_tween()
		fade_in.tween_property(default_showcase, "modulate:a", 1.0, 0.15)
	)

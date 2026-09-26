class_name HistoricalMenuButton
extends Button

## Reusable menu button with restrained historical visual styling.
## Provides subtle hover slide, ornamental marker display, and locked states.
## Built using Godot-native controls without external asset dependencies.

signal button_activated(action_id: String)

@export var action_id: String = ""
@export var button_title: String = "Action"
@export var is_locked: bool = false
@export var locked_badge: String = "Coming Soon"

var _marker_label: Label
var _title_label: Label
var _content_box: HBoxContainer
var _tween: Tween

const COLOR_NORMAL_TEXT: Color = Color(0.85, 0.82, 0.77, 1.0) # Warm bone / parchment
const COLOR_HOVER_TEXT: Color = Color(0.95, 0.88, 0.72, 1.0)  # Subtle refined bronze-gold
const COLOR_LOCKED_TEXT: Color = Color(0.42, 0.40, 0.38, 1.0) # Muted stone
const COLOR_MARKER: Color = Color(0.78, 0.66, 0.42, 1.0)      # Antique brass

func _ready() -> void:
	custom_minimum_size = Vector2(340, 48)
	flat = true
	alignment = HORIZONTAL_ALIGNMENT_LEFT
	focus_mode = FOCUS_ALL
	
	_build_visuals()
	_apply_styling()
	_update_text()
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	focus_entered.connect(_on_mouse_entered)
	focus_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

func set_locked_state(locked: bool, badge: String = "Coming Soon") -> void:
	is_locked = locked
	locked_badge = badge
	disabled = is_locked
	_update_text()
	_apply_styling()

func _build_visuals() -> void:
	# Container for marker and label inside the button
	_content_box = HBoxContainer.new()
	_content_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_content_box.anchors_preset = Control.PRESET_FULL_RECT
	_content_box.anchor_right = 1.0
	_content_box.anchor_bottom = 1.0
	_content_box.offset_left = 16.0
	_content_box.offset_right = -16.0
	_content_box.add_theme_constant_override("separation", 10)
	add_child(_content_box)
	
	# Small ornamental diamond marker
	_marker_label = Label.new()
	_marker_label.text = "◆"
	_marker_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_marker_label.modulate = Color(COLOR_MARKER.r, COLOR_MARKER.g, COLOR_MARKER.b, 0.0) # Hidden by default
	_marker_label.add_theme_font_size_override("font_size", 14)
	_content_box.add_child(_marker_label)
	
	# Main title label
	_title_label = Label.new()
	_title_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_title_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_title_label.add_theme_font_size_override("font_size", 18)
	_content_box.add_child(_title_label)

func _update_text() -> void:
	if not _title_label:
		return
	
	if is_locked:
		_title_label.text = button_title + "  [" + locked_badge + "]"
		_title_label.modulate = COLOR_LOCKED_TEXT
	else:
		_title_label.text = button_title
		_title_label.modulate = COLOR_NORMAL_TEXT

func _apply_styling() -> void:
	# Normal state: subtle dark slate base with faint 1px stone border
	var normal_box := StyleBoxFlat.new()
	normal_box.bg_color = Color(0.09, 0.10, 0.12, 0.75)
	normal_box.border_color = Color(0.24, 0.22, 0.20, 0.8)
	normal_box.set_border_width_all(1)
	normal_box.set_corner_radius_all(2)
	add_theme_stylebox_override("normal", normal_box)
	
	# Hover state: warmer slate with restrained antique brass border
	var hover_box := StyleBoxFlat.new()
	hover_box.bg_color = Color(0.13, 0.14, 0.17, 0.9)
	hover_box.border_color = Color(0.62, 0.52, 0.35, 0.9)
	hover_box.set_border_width_all(1)
	hover_box.border_width_left = 3 # Subtle chisel edge
	hover_box.set_corner_radius_all(2)
	add_theme_stylebox_override("hover", hover_box)
	
	# Pressed state
	var pressed_box := StyleBoxFlat.new()
	pressed_box.bg_color = Color(0.08, 0.08, 0.10, 0.95)
	pressed_box.border_color = Color(0.75, 0.64, 0.44, 1.0)
	pressed_box.set_border_width_all(1)
	pressed_box.set_corner_radius_all(2)
	add_theme_stylebox_override("pressed", pressed_box)
	
	# Disabled state: faint border, flat muted plate
	var disabled_box := StyleBoxFlat.new()
	disabled_box.bg_color = Color(0.07, 0.08, 0.09, 0.5)
	disabled_box.border_color = Color(0.18, 0.17, 0.16, 0.4)
	disabled_box.set_border_width_all(1)
	disabled_box.set_corner_radius_all(2)
	add_theme_stylebox_override("disabled", disabled_box)
	
	# Focus style
	add_theme_stylebox_override("focus", hover_box)

func _on_mouse_entered() -> void:
	if disabled:
		return
	
	if _tween and _tween.is_running():
		_tween.kill()
	
	_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	# Subtle 6px right slide for tactile response
	_tween.tween_property(_content_box, "offset_left", 22.0, 0.12)
	# Fade in small ornamental diamond marker
	_tween.tween_property(_marker_label, "modulate:a", 1.0, 0.12)
	# Restrained text color shift
	_tween.tween_property(_title_label, "modulate", COLOR_HOVER_TEXT, 0.12)

func _on_mouse_exited() -> void:
	if disabled:
		return
	
	if _tween and _tween.is_running():
		_tween.kill()
	
	_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	_tween.tween_property(_content_box, "offset_left", 16.0, 0.12)
	_tween.tween_property(_marker_label, "modulate:a", 0.0, 0.12)
	_tween.tween_property(_title_label, "modulate", COLOR_NORMAL_TEXT, 0.12)

func _on_pressed() -> void:
	button_activated.emit(action_id)

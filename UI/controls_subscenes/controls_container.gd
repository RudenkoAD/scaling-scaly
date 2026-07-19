extends HBoxContainer
class_name ControlsContainer

@onready var label: Label = $Label
@onready var button: Button = $Button

@export var display_name: String
@export var action_name: String
@export var action_bind: String

signal control_rebound(action_name: String, action_bind: InputEventKey)
var waiting = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = display_name
	action_bind = InputMap.action_get_events(action_name)[0].as_text()
	button.text = action_bind
	

func _on_button_pressed() -> void:
	waiting = true


func _input(event: InputEvent) -> void:
	if waiting and event.is_class("InputEventKey"):
		waiting = false
		control_rebound.emit(action_name, event)
		button.text = event.as_text()

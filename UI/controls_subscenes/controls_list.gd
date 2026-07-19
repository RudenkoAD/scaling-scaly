extends VBoxContainer

const CONTROLS_CONTAINER = preload("res://UI/controls_subscenes/controls_container.tscn")

@export var prefix: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var actions = InputMap.get_actions().slice(91)
	for action in actions:
		if prefix in action:
			var new_cont: ControlsContainer = CONTROLS_CONTAINER.instantiate()
			new_cont.action_name = action
			new_cont.action_bind = InputMap.action_get_events(action)[0].as_text()
			new_cont.control_rebound.connect(_on_control_rebound)
			self.add_child(new_cont)
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_control_rebound(action_name: String, action_bind: InputEventKey):
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, action_bind)

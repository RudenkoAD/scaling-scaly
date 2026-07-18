extends TextureRect


# Called when the node enters the scene tree for the first time.
@export var scroll_speed := 0.05
func _ready():
	self.material.set("shader_parameter/scroll_speed", scroll_speed)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node2D

@export var colour: int;

var isPressed = false;
@onready var off: Sprite2D = $Area2D/Off
@onready var on: Sprite2D = $Area2D/On

func _ready() -> void:
	isPressed = false;

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (isPressed == false) :
		InteractiveTilesSignals.DoorOpen.emit(colour);
		off.visible = true;
		on.visible = false;
	isPressed = true;

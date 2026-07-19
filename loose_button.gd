extends Node2D

@export var colour: int;

@onready var on: Sprite2D = $Area2D/On
@onready var off: Sprite2D = $Area2D/Off

var isPressed = false;

func _ready() -> void:
	isPressed = false;

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (isPressed == false) :
		InteractiveTilesSignals.DoorOpen.emit(colour);
		off.visible = false;
		on.visible = true;
	isPressed = true;

func _on_area_2d_body_exited(body: Node2D) -> void:
	if (isPressed == true) :
		InteractiveTilesSignals.DoorClose.emit(colour);
		off.visible = true;
		on.visible = false;
	isPressed = false;

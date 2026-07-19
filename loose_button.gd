extends Node2D

@export var colour: int;

var isPressed = false;

func _ready() -> void:
	isPressed = false;

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (isPressed == false) :
		InteractiveTilesSignals.DoorOpen.emit(colour);
		$Off.visible = true;
		$On.visible = false;
	isPressed = true;

func _on_area_2d_body_exited(body: Node2D) -> void:
	if (isPressed == true) :
		InteractiveTilesSignals.DoorClose.emit(colour);
		$Off.visible = false;
		$On.visible = true;
	isPressed = false;

extends Node2D

@export var colour: int

@onready var box: StaticBody2D = $Box
@onready var closed: Sprite2D = $Closed
@onready var open: Sprite2D = $Open


var closedCount: int = 0
var snakeOverlaps: bool = false
var playerOverlaps: bool = false
func _ready() -> void:
	InteractiveTilesSignals.DoorOpen.connect(OpenSignal)
	InteractiveTilesSignals.DoorClose.connect(CloseSignal)
	closedCount = 0
	snakeOverlaps = false
	playerOverlaps = false

func OpenSignal(signalColour: int) -> void:
	if (signalColour != colour):
		return
	if (closedCount == 0):
		box.set_deferred("disabled", true)
		closed.visible = false
		open.visible = true
	closedCount += 1

func CloseSignal(signalColour: int) -> void:
	if (signalColour != colour):
		return
	if (closedCount == 1):
		box.set_deferred("disabled", false)
		closed.visible = true
		open.visible = false
		if (playerOverlaps):
			InteractiveTilesSignals.PCSquashedByDoor.emit()
		if (snakeOverlaps):
			InteractiveTilesSignals.SnakeSquashedByDoor.emit()
	closedCount -= 1

func _on_inner_body_entered(body: PhysicsBody2D) -> void:
	playerOverlaps = (body.collision_layer & 1) != 0
	snakeOverlaps = (body.collision_layer & 2) != 0 

func _on_inner_body_exited(body: PhysicsBody2D) -> void:
	playerOverlaps = (body.collision_layer & 1) == 0
	snakeOverlaps = (body.collision_layer & 2) == 0 

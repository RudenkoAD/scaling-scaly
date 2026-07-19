extends Node

#preloaded scenes
const CONTROLS = preload("res://UI/controls.tscn")
const CONFIG = preload("res://UI/config.tscn")
const MAIN_MENU = preload("res://UI/main_menu.tscn")
const LEVEL_1 = preload("res://levels/level1.tscn")
const LOSE_SCREEN = preload("res://UI/overlays/lose_screen.tscn")

var current_scene: Node = null
enum GameScene {MainMenu, Config, Controls, Level1}
static var scenes:Dictionary = {
	GameScene.MainMenu: MAIN_MENU,
	GameScene.Config: CONFIG,
	GameScene.Controls: CONTROLS,
	GameScene.Level1: LEVEL_1
}

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)
	InteractiveTilesSignals.PCTouchedSpikes.connect(_on_pc_death)
	InteractiveTilesSignals.PCSquashedByDoor.connect(_on_pc_death)

func change_scene(scene: GameScene) -> void:
	call_deferred("_deferred_change_scene", scene)

func _deferred_change_scene(scene: GameScene) -> void:
	var new_scene = scenes[scene].instantiate()
	if current_scene:
		remove_child(current_scene)
		current_scene.queue_free()
	add_child(new_scene)
	current_scene = new_scene

func _on_pc_death():
	add_child(LOSE_SCREEN.instantiate())
	print("you lose!")

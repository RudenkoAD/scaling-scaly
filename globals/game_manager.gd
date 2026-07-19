extends Node

#preloaded scenes
const CONTROLS = preload("res://UI/controls.tscn")
const CONFIG = preload("res://UI/config.tscn")
const MAIN_MENU = preload("res://UI/main_menu.tscn")


var current_scene: Node = null
enum GameScene {MainMenu, Config, Controls}
static var scenes:Dictionary = {
	GameScene.MainMenu: MAIN_MENU,
	GameScene.Config: CONFIG,
	GameScene.Controls: CONTROLS
}

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)

func change_scene(scene: GameScene) -> void:
	call_deferred("_deferred_change_scene", scene)

func _deferred_change_scene(scene: GameScene) -> void:
	var new_scene = scenes[scene].instantiate()
	if current_scene:
		remove_child(current_scene)
		current_scene.queue_free()
	add_child(new_scene)
	current_scene = new_scene

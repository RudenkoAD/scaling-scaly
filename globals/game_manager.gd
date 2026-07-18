extends Node

#preloaded scenes
const MAIN_MENU = preload("uid://7gocfy52s5be")


var current_scene: Node = null
enum GameScene {MainMenu}
static var scenes:Dictionary = {
	GameScene.MainMenu: MAIN_MENU
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

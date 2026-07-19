extends Node2D

# шаблон класса сегмента и массив ссылок на сегменты
const Snake_Segment_Scene = preload("res://snake/snake_segment/snake_segment_scene.tscn")
var segment_nodes: Array = []

# размер одной клетки
const GRID_SIZE = 70

# позиция в клетках
var segment_poses: Array = [Vector2(5,5), Vector2(4,5), Vector2(3,5)]
var curr_direction: Vector2 = Vector2.RIGHT
var next_direction: Vector2 = Vector2.RIGHT

# змейка двигается 1раз в dt
@export var dt = 1



func _ready():
	for i in range(segment_poses.size()):
		var seg = Snake_Segment_Scene.instantiate()
		add_child(seg)
		seg.position = segment_poses[i] * GRID_SIZE
		segment_nodes.append(seg)



func move_snake():
	curr_direction = next_direction
	
	# Если бошка будет отличаться от тела, то надо будет по другому писать
	var new_head_pos = segment_poses[0] + curr_direction
	segment_poses.insert(0, new_head_pos)
	# Если она съела еду, то хвост не удаляется
	segment_poses.pop_back()
	
	# Я так понял, Антоша хочет, чтобы сегменты "пульсировали"
	animate_segments()

func animate_segments():
	# формально нам надо,чтобы пульсация была паралельна передвижению и плавна
	for i in range(segment_poses.size()):
		var seg = segment_nodes[i]
		var target_pos = segment_poses[i] * GRID_SIZE
		
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		
		# как у нас будет устроено время? dt
		tween.tween_property(seg, "position", target_pos, dt) \
			 .set_trans(Tween.TRANS_SINE)
		
		# каждый следующий сегмент чуть позже
		var delay = i * 0.05
		tween.tween_property(seg, "scale", Vector2(1, 10), dt/2) \
			 #.set_delay(0) \
			 .set_trans(Tween.TRANS_SINE)
		tween.tween_property(seg, "scale", Vector2(1.0, 1.0), dt/2) \
			 #.set_delay(dt/2) \
			 .set_trans(Tween.TRANS_SINE)

func _input(event):
	# на 180 поворачиваться нельзя
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_UP:
				if curr_direction != Vector2.DOWN:
					next_direction = Vector2.UP
			KEY_DOWN:
				if curr_direction != Vector2.UP:
					next_direction = Vector2.DOWN
			KEY_LEFT:
				if curr_direction != Vector2.RIGHT:
					next_direction = Vector2.LEFT
			KEY_RIGHT:
				if curr_direction != Vector2.LEFT:
					next_direction = Vector2.RIGHT


func _on_timer_timeout() -> void:
	move_snake()

extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const IDLE_SPEED_TRESHOLD = 30.0
const IDLE_TIMEOUT_MILLISECONDS = 5.0 * 1000

@onready var last_active = Time.get_ticks_msec()

@onready var _animation_sprite = $AnimatedSprite2D

func is_idling() -> bool:
	return Time.get_ticks_msec() - last_active > IDLE_TIMEOUT_MILLISECONDS

func mark_active() -> void:
	if is_idling():
		_animation_sprite.play("default")
	last_active = Time.get_ticks_msec()


func _ready() -> void:
	_animation_sprite.play("default")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if velocity.length() > IDLE_SPEED_TRESHOLD:
		mark_active()
	
	if is_idling():
		_animation_sprite.play("idle")

	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		_animation_sprite.play("default")

	if Input.is_action_just_pressed("player_breakdance") and is_on_floor():
		mark_active()
		if _animation_sprite.animation == "player still":
			_animation_sprite.play("default")
		else:
			_animation_sprite.play("player still")

	var direction := Input.get_axis("player_left", "player_right")
	if direction:
		mark_active()
		_animation_sprite.play("default")
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

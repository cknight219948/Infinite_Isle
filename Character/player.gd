extends CharacterBody2D

@export var Speed : float = 240.0
@export var Jump_velocity : float = -200.0
@export var double_jump_velocity : float = -150.0
@onready var animated_sprite = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += Vector2(-12,-12) + get_gravity() * delta
		
	else:
		has_double_jumped = false

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()
		velocity.y = Jump_velocity
	elif not has_double_jumped and Input.is_action_just_pressed("ui_accept"):
		velocity.y = double_jump_velocity
		has_double_jumped = true
		
		pass

	direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity.x = direction.x * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")

func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true

func jump():
	velocity.y = Jump_velocity
	animated_sprite.play("jump start")
	animation_locked = true

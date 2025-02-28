extends CharacterBody2D

@export var Speed : float = 240.0
@export var Jump_velocity : float = -200.0
@export var double_jump_velocity : float = -150.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false

func _ready():
	animation_tree.active = true
	
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += Vector2(-12,-12) + get_gravity() * delta
		was_in_air = true
	else:
		has_double_jumped = false
		
		if was_in_air == true:
			land()
			
		was_in_air = false
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()
		velocity.y = Jump_velocity
	elif not has_double_jumped and Input.is_action_just_pressed("ui_accept"):
		velocity.y = double_jump_velocity
		has_double_jumped = true

	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x :
		velocity.x = direction.x * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
	
	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)

	#if not animation_locked:
		#if not is_on_floor():
			#animated_sprite.play("jump_loop")
		#else:
			#if direction.x != 0:
				#animated_sprite.play("run")
			#else:
				#animated_sprite.play("idle")

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true

func jump():
	velocity.y = Jump_velocity
	#animated_sprite.play("jump_start")
	animation_locked = true

func double_jump():
	velocity.y = double_jump_velocity
	#animated_sprite.play("jump_double")
	animation_locked = true


func land():
	#animated_sprite.play("jump_end")
	animation_locked = true

#func _on_animated_sprite_2d_animation_finished() -> void:
	#if(["jump_end", "jump_start", "jump_double"].has(animated_sprite.animation)):
		#animation_locked = false

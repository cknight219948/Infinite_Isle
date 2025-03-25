extends CharacterBody2D

@export var Speed : float = 280.0
@export var double_jump_velocity : float = -150.0
@onready var sprite: Sprite2D = $Sprite2D2
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var direction : float
var was_in_air : bool = false
var jump_count = 0
var near_ground = true

func _ready():
	animation_tree.active = true
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += Vector2(-13,-13) + get_gravity() * delta
		was_in_air = true
	else:
		has_double_jumped = false
		
		if was_in_air == true:
			land()
			
		was_in_air = false
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#jump()
		jump_count += 1
		pass
		double_jump()
		
	elif jump_count < 2 and Input.is_action_just_pressed("ui_accept"):
		jump_count += 1
		double_jump()
	elif is_on_floor():
		jump_count = 0
		
	direction = Input.get_axis("left", "right")
	if direction !=0 && state_machine.check_if_can_move():
		velocity.x = direction * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
	
	move_and_slide()
	update_animation()
	update_facing_direction()
	
	near_ground = $RayCast2D.is_colliding()

func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction)
	
	#if velocity == Vector2.ZERO:
		#animation_tree.set("parameters/conditions/idle", true)
		#animation_tree.set("parameters/conditions/moving", false)
	#else:
		#animation_tree.set("parameters/conditions/idle", false)
		#animation_tree.set("parameters/conditions/moving", true)
	#
	animation_tree.set("parameters/conditions/on_floor", is_on_floor())
	
	
	#if not animation_locked:
		#if not is_on_floor():
			#animated_sprite.play("jump_loop")
		#else:
			#if direction.x != 0:
				#animated_sprite.play("run")
			#else:
				#animated_sprite.play("idle")

func update_facing_direction():
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

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

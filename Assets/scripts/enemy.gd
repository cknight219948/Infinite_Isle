extends Node2D

const SPEED = 60

var direction = 1

@onready var Ray_Cast_Right = $RayCastRight
@onready var Ray_Cast_Left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	if Ray_Cast_Right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if Ray_Cast_Left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * SPEED * delta
	pass

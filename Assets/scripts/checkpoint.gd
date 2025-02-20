extends Area2D

@export var checkpoint_number = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("CheckPoint")
		if checkpoint_number > Global.current_checkpoint:
			Global.current_checkpoint = checkpoint_number
			body.current_spawn = global_position

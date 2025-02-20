extends Area2D

@onready var game_manager: Node = $"../../GameManager"
@export var f1 = false
@export var f2 = false
func _on_body_entered(body: Node2D) -> void:
	print("+1 Coin!")
	#visible = false
	get_parent().coins_dict[name]["spawned"]= false
	print(get_parent().coins_dict[name])
	queue_free()

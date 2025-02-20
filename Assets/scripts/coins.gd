extends Node
class_name CoinSpawner
var coins_dict := {}
@export var coin : PackedScene
func _ready() -> void:
	for coin in get_children():
		coins_dict[coin.name]={"pos":coin.global_position, "flag1":coin.f1, "flag2":coin.f2, "spawned":true, "name":coin.name}

	
	pass # Replace with function body.

func spawn():
	for i in coins_dict:
		print(i)
		if not coins_dict[i]["spawned"] and Global.current_checkpoint ==0:
			var new_coin = coin.instantiate()
			new_coin.name = coins_dict[i]["name"]
			new_coin.global_position = coins_dict[i]["pos"]
			add_child(new_coin)
			#-1 to coins
			print("spawn")
		elif not coins_dict[i]["spawned"] and (coins_dict[i]["flag1"] or coins_dict[i]["flag2"]) and Global.current_checkpoint ==1:
			var new_coin = coin.instantiate()
			new_coin.name = coins_dict[i]["name"]
			new_coin.global_position = coins_dict[i]["pos"]
			add_child(new_coin)
			print("spawn")
		elif not coins_dict[i]["spawned"] and coins_dict[i]["flag2"] and Global.current_checkpoint ==2:
			var new_coin = coin.instantiate()
			new_coin.name = coins_dict[i]["name"]
			new_coin.global_position = coins_dict[i]["pos"]
			add_child(new_coin)
			print("spawn")
			pass

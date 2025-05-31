extends Area2D

var checkpoint_manager
var player

func _ready() -> void:
	checkpoint_manager = get_node("/root/game/CheckPointManager")
	player = get_node("/root/game/player2")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		killPlayer()
		
	print("you died bro, nt")

func killPlayer():
	player.position = checkpoint_manager.last_location

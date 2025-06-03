extends Node

class_name CheckPointManager

var last_location
var player

func _ready() -> void:
	player = get_parent().get_node("Player_Kurcaci")
	last_location = player.global_position

extends Area2D

@export var speed: float = 150.0
var direction: int = 1  # 1 untuk kanan, -1 untuk kiri

func _ready():
	# Atur arah RayCast
	$RayCast2D.target_position.x = 10 * direction
	$RayCast2D.enabled = true

func _physics_process(delta):
	position.x += speed * direction * delta

	# Periksa apakah RayCast menabrak sesuatu (seperti TileMap atau dinding)
	if $RayCast2D.is_colliding():
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy.is_in_group("enemy"):
		if enemy.has_method("die"):
			enemy.die()
	
	queue_free()

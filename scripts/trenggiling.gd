extends Node2D

const SPEED = 20
var direction = 1

@onready var ray_cast_kanan = $RayCastkanan
@onready var ray_cast_kiri = $RayCastkiri
@onready var ray_cast_tepi_kanan = $RayCastTepiKanan
@onready var ray_cast_tepi_kiri = $RayCastTepiKiri
@onready var animated_sprite_2d = $AnimatedSprite2D

func _process(delta: float) -> void:
	# Balik arah kalau tidak ada tanah di tepi
	if not ray_cast_tepi_kanan.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	elif not ray_cast_tepi_kiri.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	
	# (Opsional) Balik arah kalau nabrak dinding
	if ray_cast_kanan.is_colliding():
		direction = -1
	elif ray_cast_kiri.is_colliding():
		direction = 1
	
	position.x += direction * SPEED * delta


func die():
	queue_free()

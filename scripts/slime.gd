extends Node2D

const SPEED = 25
var direction = 1
var is_dead = false  # Tambahan: status mati

@onready var ray_cast_kanan = $RayCastkanan
@onready var ray_cast_kiri = $RayCastkiri
@onready var ray_cast_tepi_kanan = $RayCastTepiKanan
@onready var ray_cast_tepi_kiri = $RayCastTepiKiri
@onready var animated_sprite_2d = $AnimatedSprite2D

func _process(delta: float) -> void:
	if is_dead:
		return  # Jika mati, hentikan logika gerak

	# Balik arah kalau tidak ada tanah di tepi
	if not ray_cast_tepi_kanan.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	elif not ray_cast_tepi_kiri.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	
	# Balik arah kalau nabrak dinding
	if ray_cast_kanan.is_colliding():
		direction = -1
	elif ray_cast_kiri.is_colliding():
		direction = 1
	
	position.x += direction * SPEED * delta

func die() -> void:
	is_dead = true
	animated_sprite_2d.play("dead")
	
	# Tunggu sampai animasi selesai
	await animated_sprite_2d.animation_finished
	
	queue_free()

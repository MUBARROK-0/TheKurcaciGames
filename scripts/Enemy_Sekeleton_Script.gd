extends Node2D

const SPEED = 20
var direction = 1
var is_dead = false  # Tambahan: status mati

@onready var ray_cast_kanan = $RayCastKanan
@onready var ray_cast_kiri = $RayCastKiri
@onready var ray_cast_tepi_kanan = $RayCastTepiKanan
@onready var ray_cast_tepi_kiri = $RayCastTepiKiri
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collisionshape2d = $Area2D/CollisionShape2D
@onready var collision = $killzone/CollisionShape2D

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

	# Nonaktifkan collider dengan aman menggunakan call_deferred
	$Area2D/CollisionShape2D.call_deferred("set_disabled", true)
	$killzone/CollisionShape2D.call_deferred("set_disabled", true)

	# Putar animasi jatuh/mati
	animated_sprite_2d.play("SekeletonDeadFall")

	# Tunggu sampai animasi selesai
	await animated_sprite_2d.animation_finished

	# Kunci posisinya agar tidak bergeser
	set_process(false)
	set_physics_process(false)

	# Ubah sprite ke kondisi 'mati diam' (1 frame statis)
	animated_sprite_2d.play("SekeletonDead")
	animated_sprite_2d.frame = 0
	animated_sprite_2d.pause()

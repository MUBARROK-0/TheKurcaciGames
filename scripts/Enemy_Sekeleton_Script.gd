extends Node2D

const SPEED = 20
var direction = 1
var is_dead = false
var is_attacking = false

const detection_offset_x = 5
const WALK_Y = 2
const ATTACK_Y = 0

@onready var ray_cast_kanan = $RayCastKanan
@onready var ray_cast_kiri = $RayCastKiri
@onready var ray_cast_tepi_kanan = $RayCastTepiKanan
@onready var ray_cast_tepi_kiri = $RayCastTepiKiri
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collisionshape2d = $Area2D/CollisionShape2D
@onready var detection_shape = $DetectionArea/CollisionShape2D

func _process(delta: float) -> void:
	if is_dead or is_attacking:
		return  # Hentikan semua saat mati atau menyerang

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
	
	# Gerakkan posisi Skeleton
	position.x += direction * SPEED * delta

	# Pastikan CollisionShape2D untuk deteksi tetap berada di depan
	detection_shape.position.x = direction * abs(detection_offset_x)

	# Putar animasi jalan jika belum diputar
	if not animated_sprite_2d.is_playing() or animated_sprite_2d.animation != "SekeletonWalk":
		animated_sprite_2d.position.y = WALK_Y
		animated_sprite_2d.play("SekeletonWalk")

func die() -> void:
	is_dead = true

	# Nonaktifkan collider dengan aman menggunakan call_deferred
	collisionshape2d.call_deferred("set_disabled", true)
	detection_shape.call_deferred("set_disabled", true)

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

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not is_attacking and not is_dead:
		is_attacking = true
		animated_sprite_2d.position.y = ATTACK_Y
		animated_sprite_2d.play("SekeletonAttack")
		await animated_sprite_2d.animation_finished
		is_attacking = false

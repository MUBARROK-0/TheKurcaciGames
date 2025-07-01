extends Node2D

const SPEED = 15
var direction = 1
var is_dead = false
var is_attacking = false

const detection_offset_x = 10
const attack_offset_x = 12
const WALK_Y = 2
const WALK_X = 0
const ATTACK_Y = 0
const ATTACK_X = -7
const DEAD_Y = 2
const DEADFALL_Y = 2

@onready var ray_cast_kanan = $RayCastKanan
@onready var ray_cast_kiri = $RayCastKiri
@onready var ray_cast_tepi_kanan = $RayCastTepiKanan
@onready var ray_cast_tepi_kiri = $RayCastTepiKiri
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collisionshape2d = $BodyEnemy/CollisionShape2D
@onready var detection_shape = $DetectionArea/CollisionShape2D
@onready var attack_collision = $AttackArea/CollisionShape2D

func _ready() -> void:
	animated_sprite_2d.connect("frame_changed", Callable(self, "_on_frame_changed"))
	attack_collision.disabled = true

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
	attack_collision.position.x = direction * abs(attack_offset_x)
	collisionshape2d.position.x = direction * abs(detection_offset_x)
	

	# Putar animasi jalan jika belum diputar
	if not animated_sprite_2d.is_playing() or animated_sprite_2d.animation != "SekeletonWalk":  # atau 2 pixel, sesuai pergeseran
		animated_sprite_2d.position.y = WALK_Y
		animated_sprite_2d.play("SekeletonWalk")

func _on_frame_changed() -> void:
	if animated_sprite_2d.animation == "SekeletonAttack":
		if animated_sprite_2d.frame == 7:
			attack_collision.call_deferred("set_disabled", false)
			print("Attack collision AKTIF (frame 7)")
		else:
			attack_collision.call_deferred("set_disabled", true)
	else:
		attack_collision.call_deferred("set_disabled", true)

func die() -> void:
	is_dead = true

	# Nonaktifkan collider dengan aman menggunakan call_deferred
	collisionshape2d.call_deferred("set_disabled", true)
	detection_shape.call_deferred("set_disabled", true)
	attack_collision.call_deferred("set_disabled", true)

	# Putar animasi jatuh/mati
	animated_sprite_2d.play("SekeletonDeadFall")
	animated_sprite_2d.position.y = DEADFALL_Y

	# Tunggu sampai animasi selesai
	await animated_sprite_2d.animation_finished

	# Kunci posisinya agar tidak bergeser
	set_process(false)
	set_physics_process(false)

	# Ubah sprite ke kondisi 'mati diam' (1 frame statis)
	animated_sprite_2d.play("SekeletonDead")
	animated_sprite_2d.position.y = DEAD_Y
	animated_sprite_2d.frame = 0
	animated_sprite_2d.pause()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not is_attacking and not is_dead:
		is_attacking = true
		animated_sprite_2d.position.y = ATTACK_Y
		animated_sprite_2d.position.x = direction * abs(ATTACK_X)
		animated_sprite_2d.play("SekeletonAttack")
		await animated_sprite_2d.animation_finished
		is_attacking = false
		animated_sprite_2d.position.x = direction * abs(WALK_X)

func _on_attack_area_body_entered(body: Node2D) -> void:
	print("Yang masuk AttackArea musuh: ", body.name, " parent: ", body.get_parent().name)
	if is_attacking and not is_dead:
		if body.is_in_group("Player"):
			if body.has_method("die"):
				body.die()  # panggil fungsi mati pada player
				print("Player dipanggil die() oleh Skeleton")

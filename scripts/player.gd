extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -320.0

@onready var animated_sprite_2d = $AnimatedSprite2D

var is_attacking: bool = false

func _ready():
	# Hubungkan sinyal ketika animasi selesai
	animated_sprite_2d.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _physics_process(delta: float) -> void:
	# Tambahkan gravitasi jika tidak di lantai
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Tombol lompat, hanya jika tidak sedang menyerang
	if Input.is_action_just_pressed("lompat") and is_on_floor() and not is_attacking:
		velocity.y = JUMP_VELOCITY

	# Tombol serang, hanya jika tidak sedang menyerang
	if Input.is_action_just_pressed("serang") and not is_attacking:
		is_attacking = true
		animated_sprite_2d.play("serang")

	# Dapatkan arah input
	var direction := Input.get_axis("bergerak_kiri", "bergerak_kanan")

	# Balik arah sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	# Jika tidak sedang menyerang, mainkan animasi lain sesuai kondisi
	if not is_attacking:
		if is_on_floor():
			if direction == 0:
				animated_sprite_2d.play("idle")
			else:
				animated_sprite_2d.play("lari")
		else:
			animated_sprite_2d.play("lompat")

	# Gerakkan karakter (bergerak hanya jika tidak sedang menyerang)
	if not is_attacking:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Callback saat animasi selesai
func _on_animation_finished():
	if animated_sprite_2d.animation == "serang":
		is_attacking = false

extends CharacterBody2D

class_name player2

@onready var Sprite = $Sprite2D
@onready var animationplayer = $AnimationPlayer

const SPEED = 80.0
const JUMP_VELOCITY = -310.0


var is_attacking: bool = false

func _ready():
	# Hubungkan sinyal ketika animasi selesai
	animationplayer.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _physics_process(delta: float) -> void:
	# Tambahkan gravitasi jika tidak di lantai
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Tombol lompat, hanya jika tidak sedang menyerang
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not is_attacking:
		velocity.y = JUMP_VELOCITY

	# Tombol serang, hanya jika tidak sedang menyerang
	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		animationplayer.play("attack")

	# Dapatkan arah input
	var direction := Input.get_axis("ui_left", "ui_right")
	
	var overlapping_objects = $AttackArea.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("enemy"):
			area.get_parent().die()

	# Balik arah sprite
	if direction > 0:
		Sprite.flip_h = false
	elif direction < 0:
		Sprite.flip_h = true

	# Jika tidak sedang menyerang, mainkan animasi lain sesuai kondisi
	if not is_attacking:
		if is_on_floor():
			if direction == 0:
				animationplayer.play("DiamDanBergerak")
			else:
				animationplayer.play("lari")
		else:
			animationplayer.play("lompat")

	# Gerakkan karakter (bergerak hanya jika tidak sedang menyerang)
	if not is_attacking:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Callback saat animasi selesai
func _on_animation_finished(anim_name: String):
	if anim_name == "attack":
		is_attacking = false

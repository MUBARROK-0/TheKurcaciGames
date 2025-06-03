extends CharacterBody2D

@onready var Sprite = $Sprite2D
@onready var animationplayer = $AnimationPlayer
@onready var attack_area = $AttackArea
@onready var attack_shape = $AttackArea/CollisionShape2D

const SPEED = 80.0
const JUMP_VELOCITY = -310.0

var is_attacking: bool = false

func _ready():
	# Nonaktifkan area serang di awal
	attack_shape.disabled = true
	
	# Hubungkan sinyal saat animasi selesai
	animationplayer.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _physics_process(delta: float) -> void:
	# Tambahkan gravitasi jika tidak di lantai
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Lompat jika tombol ditekan dan tidak sedang menyerang
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not is_attacking:
		velocity.y = JUMP_VELOCITY

	# Tombol serang
	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		attack_shape.disabled = false  # Aktifkan area serang
		animationplayer.play("KurcaciBlock")

	# Arah gerak horizontal
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Balik arah AttackArea
	if direction < 0:
		attack_area.scale.x = -abs(attack_area.scale.x)
	elif direction > 0:
		attack_area.scale.x = abs(attack_area.scale.x)

	# Balik arah Sprite
	if direction > 0:
		Sprite.flip_h = false
	elif direction < 0:
		Sprite.flip_h = true

	# Mainkan animasi jika tidak sedang menyerang
	if not is_attacking:
		if is_on_floor():
			if direction == 0:
				animationplayer.play("KurcaciIdle")
			else:
				animationplayer.play("KurcaciRun")
		else:
			animationplayer.play("KurcaciJump")

	# Gerakkan karakter jika tidak menyerang
	if not is_attacking:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Fungsi ini dipanggil dari animasi "attack" (via AnimationPlayer Call Method Track)


# Callback saat animasi selesai
func _on_animation_finished(anim_name: String):
	if anim_name == "KurcaciBlock":
		is_attacking = false
		attack_shape.disabled = true


func _on_attack_area_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if is_attacking and enemy.is_in_group("enemy"):
		if enemy.has_method("die"):
			enemy.die()

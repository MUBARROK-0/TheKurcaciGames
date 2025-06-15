extends CharacterBody2D

@onready var Sprite = $Sprite2D
@onready var animationplayer = $AnimationPlayer
@onready var attack_area = $AttackArea
@onready var attack_shape = $AttackArea/CollisionShape2D
@onready var bullet = preload("res://scenes/Player_Kurcaci_Bullet.tscn")

# Variabel kecepatan lari dan lompatan player
const SPEED = 80.0
const JUMP_VELOCITY = -310.0

# Variabel untuk attack block dan range attack player
var is_attacking: bool = false
var is_range_attacking: bool = false

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
	if not is_attacking and not is_range_attacking:
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

	if Input.is_action_just_pressed("Button_Range_Attack") and not is_attacking and not is_range_attacking:
		is_range_attacking = true
		animationplayer.play("KurcaciRangeAttack")

		# Start the delay timer
		$RangeAttackDelayTimer.start()

# Callback saat animasi selesai
func _on_animation_finished(anim_name: String):
	if anim_name == "KurcaciBlock":
		is_attacking = false
		attack_shape.disabled = true
	elif anim_name == "KurcaciRangeAttack":
		is_range_attacking = false

func _on_attack_area_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if is_attacking and enemy.is_in_group("enemy"):
		if enemy.has_method("die"):
			enemy.die()

func _on_range_attack_delay_timer_timeout() -> void:
	var bullet_temp = bullet.instantiate()
	bullet_temp.direction = 1 if not Sprite.flip_h else -1
	bullet_temp.position = global_position
	get_parent().add_child(bullet_temp)

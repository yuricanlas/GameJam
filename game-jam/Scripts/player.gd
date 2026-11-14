class_name Player
extends CharacterBody2D

signal trash_erased

@export var playerName: String
@export var max_health: int = 100
@export var health: int = max_health
@export var speed: float = 200.0
@export var trash_tile: TileMapLayer

@onready var money = 0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var facing := "up"


func _ready() -> void:
	add_to_group("player")
	# Use right-click if the project is missing an attack binding
	if not InputMap.has_action("attack"):
		InputMap.add_action("attack")

	if InputMap.action_get_events("attack").is_empty():
		var right_click := InputEventMouseButton.new()
		right_click.button_index = MOUSE_BUTTON_RIGHT
		InputMap.action_add_event("attack", right_click)
		
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	platform_floor_layers = 0
	platform_wall_layers = 0

func attacked(damage: int) -> void:
	health -= damage
<<<<<<< HEAD
	# if health <= 0: gameOver
	
=======
	
	if health <= 0 and not dead:
		$NoHealthSound.play()
		dead = true
>>>>>>> origin/HUD-branch-sfx


func heal(patch: int) -> void:
	health = mini(health + patch, max_health)


func _physics_process(_delta: float) -> void:

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed
	move_and_slide()

<<<<<<< HEAD
	# Let the swing finish before playing idle or walk.
	if sprite.is_playing() and sprite.animation in [&"attack_left", &"attack_right"]:
=======
	if input_dir == Vector2.ZERO:
		$AnimatedSprite2D.play("idle_" + facing)
		if $StepSounds.playing:
			$StepSounds.stop()
>>>>>>> origin/HUD-branch-sfx
		return
		
	if not $StepSounds.playing:
		$StepSounds.play()
		print("Playing is reached")

	# Use the stronger direction when moving diagonally.
	if input_dir != Vector2.ZERO:
		if absf(input_dir.x) > absf(input_dir.y):
			facing = "right" if input_dir.x > 0 else "left"
		else:
			facing = "down" if input_dir.y > 0 else "up"

	if Input.is_action_just_pressed("attack"):
		# Swing right when facing up or down.
		facing = "left" if facing == "left" else "right"
		var attack_animation := &"attack_left" if facing == "left" else &"attack_right"
		sprite.play(attack_animation)
		$Weapon.attack(facing)
		return

	if input_dir == Vector2.ZERO:
		sprite.play("idle_" + facing)
	else:
		sprite.play("move_" + facing)

<<<<<<< HEAD

func _on_vacuum_trash_erased() -> void:
	trash_erased.emit()
=======
	$AnimatedSprite2D.play("move_" + facing)
	

func _on_vacuum_trash_erased() -> void:
	emit_signal("trash_erased")

func _on_step_sounds_finished() -> void:
	$StepSounds.play()
>>>>>>> origin/HUD-branch-sfx

class_name Player
extends CharacterBody2D

signal trash_erased

@export var playerName: String
@export var health: int
@export var max_health: int = 100
@export var speed: float = 200.0
@export var trash_tile: TileMapLayer

@onready var money = 0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var facing := "up"


func _ready() -> void:
	# Use right-click if the project is missing an attack binding.
	if not InputMap.has_action("attack"):
		InputMap.add_action("attack")

	if InputMap.action_get_events("attack").is_empty():
		var right_click := InputEventMouseButton.new()
		right_click.button_index = MOUSE_BUTTON_RIGHT
		InputMap.action_add_event("attack", right_click)


func attacked(damage: int) -> void:
	health -= damage


func heal(patch: int) -> void:
	health = mini(health + patch, max_health)


func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed
	move_and_slide()

	# Let the swing finish before playing idle or walk.
	if sprite.is_playing() and sprite.animation in [&"attack_left", &"attack_right"]:
		return

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


func _on_vacuum_trash_erased() -> void:
	trash_erased.emit()

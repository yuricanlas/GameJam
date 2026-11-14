class_name Enemy
extends CharacterBody2D

signal health_changed(new_health)
signal died

@export var contact_damage := 5
@export var move_speed := 15.0  # Wandering speed in pixels per second.
@export var chase_radius := 180.0
@export var chase_speed_multiplier := 6.0
@export var contact_hit_interval := 1.0  # Seconds between hits.

@onready var body_shape: CollisionShape2D = $CollisionShape2D
@onready var damage_area: Area2D = $DamageArea

var health := 100
var move_direction := Vector2.ZERO
var time_until_turn := 0.0
var time_until_contact_hit := 0.0


func _ready() -> void:
	visible = true

	# Use top down movement
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

	# Prevent the enemy from riding other bodies like moving platforms
	platform_floor_layers = 0
	platform_wall_layers = 0


func take_damage(amount: int) -> void:
	if health <= 0:
		return  # Prevent multiple death signals

	health = maxi(0, health - amount)
	health_changed.emit(health)

	if health == 0:
		# GameMap reads our stats and schedules a stronger replacement
		died.emit()
		queue_free()


func _physics_process(delta: float) -> void:
	if health <= 0:
		return

	var player := get_tree().get_first_node_in_group("player") as Player
	var chasing := false

	if player != null:
		# Aim at the player's solid collider if it is available
		var target_position := player.global_position
		var player_shape := player.get_node_or_null("CollisionShape2D") as CollisionShape2D

		if player_shape != null:
			target_position = player_shape.global_position

		# Measure from our collider to account for its offset
		var to_player := target_position - body_shape.global_position
		chasing = to_player.length() <= chase_radius

		if chasing:
			# Follow the player even when they are standing still
			var chase_speed := move_speed * chase_speed_multiplier
			velocity = (to_player / delta).limit_length(chase_speed)
			time_until_turn = 0.0

	if not chasing:
		time_until_turn -= delta

		# Pick a new wandering direction once a second
		if time_until_turn <= 0.0:
			move_direction = Vector2.RIGHT.rotated(randf_range(0.0, TAU))
			time_until_turn = 1.0

		velocity = move_direction * move_speed

	# Move once per physics frame and choose a new turn after collisions
	if move_and_slide():
		time_until_turn = 0.0

	# Keep checking for damage while the enemy is touching the player
	_check_player_contact(delta)


func _check_player_contact(delta: float) -> void:
	# Keep counting down even when the player steps away
	time_until_contact_hit = maxf(0.0, time_until_contact_hit - delta)

	var player := _get_contact_player()
	if player == null or time_until_contact_hit > 0.0:
		return

	# Each enemy has its own timer between contact hits
	time_until_contact_hit = contact_hit_interval
	if player.health > 0:
		player.attacked(contact_damage)
		print("Player took ", contact_damage, " contact damage")
		print("Player health: ", player.health)
	
	if player.health <= 0:
		print("Player took ", contact_damage, " contact damage")
		print("Player Died")


func _get_contact_player() -> Player:
	# Detect a player touching the enemy's solid body.
	for i in range(get_slide_collision_count()):
		var player := get_slide_collision(i).get_collider() as Player
		if player != null:
			return player

	# Also detect overlap while the enemy is standing still.
	for body in damage_area.get_overlapping_bodies():
		if body is Player:
			return body as Player

	return null


# Preserve the signal connections already saved in mob.tscn.
# Damage is handled by _check_player_contact().
func _on_damage_area_body_exited(_body: Node2D) -> void:
	pass


func _on_damage_area_body_shape_entered(
	_body_rid: RID,
	_body: Node2D,
	_body_shape_index: int,
	_local_shape_index: int
) -> void:
	pass


func _on_damage_area_body_shape_exited(
	_body_rid: RID,
	_body: Node2D,
	_body_shape_index: int,
	_local_shape_index: int
) -> void:
	pass

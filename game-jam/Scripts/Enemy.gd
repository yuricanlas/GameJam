class_name Enemy
extends CharacterBody2D

signal health_changed(new_health)
signal died

@export var contact_damage := 5  # Damage this enemy deals on touch
@export var move_speed := 15.0 # 15 pixels per seconds
var health := 100  # The enemy's starting health
var move_direction := Vector2.ZERO
var time_until_turn := 0.0

func take_damage(amount: int) -> void:
	if health <= 0:
		return # Prevent two hits from triggering two respawns.

	# Subtract the damage and keep health from going below 0
	health = maxi(0, health - amount)
	# Send the updated health to anything listening, such as a health bar
	health_changed.emit(health)

	if health == 0:
		died.emit() # Tell GameMap the enemy died so it can schedule a respawn
		queue_free() # Remove this enemy from the scene at the end of the frame

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(contact_damage)
		print("Player took ", contact_damage, " contact damage")

func _physics_process(delta: float) -> void:
	time_until_turn -= delta

	if time_until_turn <= 0.0:
		# Pick a random direction and keep it for one second.
		move_direction = Vector2.RIGHT.rotated(randf_range(0.0, TAU))
		time_until_turn = 1.0

	velocity = move_direction * move_speed

	# move_and_slide() returns true when the enemy hits something
	if move_and_slide():
		time_until_turn = 0.0

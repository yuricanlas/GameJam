class_name Enemy
extends CharacterBody2D

signal health_changed(new_health)
signal died

@export var contact_damage := 5  # Damage this enemy deals on touch
var health := 100  # The enemy's starting health

func take_damage(amount: int) -> void:
	if health <= 0:
		return # Prevent two hits from triggering two respawns.

	health = maxi(0, health - amount)
	health_changed.emit(health)

	if health == 0:
		died.emit()
		queue_free()

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(contact_damage)
		print("Player took ", contact_damage, " contact damage")

   

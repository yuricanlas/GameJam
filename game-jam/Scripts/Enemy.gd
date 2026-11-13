class_name Enemy
extends CharacterBody2D

signal health_changed(new_health)

@export var contact_damage := 5  # Damage this enemy deals on touch
var health := 100  # The enemy's starting health

func take_damage(amount: int) -> void:
	# Reduce players health and stop at 0
	health = maxi(0, health - amount)
	health_changed.emit(health)  # Notify listeners, player's health bar

func _on_damage_area_body_entered(body: Node2D) -> void:
	# Damage a player when they enter this enemy's DamageArea.
	if body.is_in_group("player"):
		body.take_damage(contact_damage)

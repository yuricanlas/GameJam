class_name Weapon
extends Node

@onready var hitbox: Area2D = $Hitbox
@export var damage : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func upgrade():
	damage *= 1.5
	
func attack() -> void:
	# Damage each enemy currently inside the weapon's hitbox.
	for body in hitbox.get_overlapping_bodies():
		if body is Enemy:
			body.take_damage(damage)
			print("Enemy health: ", body.health)

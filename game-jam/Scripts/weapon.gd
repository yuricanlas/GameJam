class_name Weapon
extends Node

@onready var hitbox: Area2D = $Hitbox
@export var damage : int = 20
@onready var hitbox_right: Area2D = $Hitbox
@onready var hitbox_left: Area2D = $LeftHitBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func upgrade():
	damage *= 1.5
	
func attack(direction: String = "right") -> void:
	var active_hitbox := hitbox_left if direction == "left" else hitbox_right
	
	$SwordSound.play()
	
	# Damage each enemy inside the hitbox for this swing.
	for body in active_hitbox.get_overlapping_bodies():
		if body is Enemy:
			body.take_damage(damage)
			print("Enemy health: ", body.health)

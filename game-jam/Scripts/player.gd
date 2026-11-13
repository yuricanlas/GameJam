class_name Player
extends CharacterBody2D

@export var playerName : String
@export var health : int
@export var max_health: int = 100
@export var speed: float = 200.0

@export var trash_tile: PackedScene

signal trash_erased

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attacked(damage: int):
	health -= damage

#Passed in a value for the amount to increase the health by
#to allow for different kinds of heals
func heal(patch: int):
	if health + patch >= max_health:
		health = max_health
	else:
		health += patch

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed
	move_and_slide()

func _on_vacuum_trash_erased() -> void:
	emit_signal("trash_erased")

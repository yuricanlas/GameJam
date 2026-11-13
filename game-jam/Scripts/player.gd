class_name Player
extends CharacterBody2D

@export var playerName : String
@export var health : int
@export var max_health: int = 100
@export var speed: float = 200.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


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
	
	process_movement()
	move_and_slide()

func process_movement() -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = input_dir * speed
	
	play_animation(input_dir)
	
func play_animation(dir: Vector2) -> void:
	if dir.x > 0: # player is moving right
		animated_sprite_2d.play("move_right")
	elif dir.x < 0: # player is moving left
		animated_sprite_2d.play("move_left")
	elif dir.y > 0: # player is moving down
		animated_sprite_2d.play("move_down")
	elif dir.y < 0: # player is moving up
		animated_sprite_2d.play("move_up")
	else:
		animated_sprite_2d.play("idle")

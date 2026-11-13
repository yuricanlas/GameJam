class_name Player
extends CharacterBody2D

@export var playerName : String
@export var health : int
@export var max_health: int = 100
@export var speed: float = 200.0

var last_direction: Vector2 = Vector2.RIGHT

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
	process_animation()
	move_and_slide()


# --------------------------------------------------
# MOVEMENT AND ANIMATION
# --------------------------------------------------
func process_movement() -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction != Vector2.ZERO:
		velocity = direction * speed
		last_direction = direction
	else:
		velocity = Vector2.ZERO
	
	
func process_animation() -> void:
	if velocity != Vector2.ZERO:
		play_animation("move", last_direction) # player is running
	else:
		play_animation("idle", last_direction)
	
func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x > 0: # player is moving right
		animated_sprite_2d.play(prefix + "_right")
	elif dir.x < 0: # player is moving left
		animated_sprite_2d.play(prefix + "_left")
	elif dir.y > 0: # player is moving down
		animated_sprite_2d.play(prefix + "_down")
	elif dir.y < 0: # player is moving up
		animated_sprite_2d.play(prefix + "_up")

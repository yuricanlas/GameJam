extends Node2D

@export var starting_enemies: Array[Enemy] = [] 
@export var enemy_scene: PackedScene
@export var respawn_points: Array[Marker2D] = []
@export var respawn_delay := 1.0
@onready var tileset: TileSet = $MapTileSet.tile_set
@onready var total_trash = $TrashTile.get_used_cells().size()
@onready var trash_cleaned = 0 # Player will be able to remove trash
@onready var money = 0

var level = TrashStats.level

signal trash_removed
signal enemy_killed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for enemy in starting_enemies:
		if not is_instance_valid(enemy):
			continue

		var on_died := _on_enemy_died.bind(enemy)
		if not enemy.died.is_connected(on_died):
			enemy.died.connect(on_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_cleaned():
	trash_cleaned = trash_cleaned + 1
	money += 10
	emit_signal("trash_removed")
	
	if trash_cleaned == total_trash:
		# We win!!
		pass
func _on_enemy_died(enemy: Enemy) -> void:
	# Save the stats before Enemy.gd frees the old enemy.
	var next_move_speed := enemy.move_speed * 1.2
	var next_contact_damage := enemy.contact_damage + 2
	var spawn_position := enemy.global_position

	await get_tree().create_timer(respawn_delay).timeout

	if enemy_scene == null:
		push_error("Assign Enemy Scene in the GameMap Inspector.")
		return

	# Pick a random spawn point if markers were assigned.
	if not respawn_points.is_empty():
		var marker: Marker2D = respawn_points.pick_random()
		spawn_position = marker.global_position

	var new_enemy := enemy_scene.instantiate() as Enemy
	new_enemy.move_speed = next_move_speed
	new_enemy.contact_damage = next_contact_damage
	new_enemy.position = to_local(spawn_position)

	# Connect this enemy so the next respawn also gets stronger.
	new_enemy.died.connect(_on_enemy_died.bind(new_enemy))
	add_child(new_enemy)
	
	
func _on_spawn_timer_timeout() -> void:
	# Spawn the mobs
	pass # Replace with function body.


func _on_mob_died() -> void:
	money += 25
	emit_signal("enemy_killed")
	pass # Replace with function body.
func _on_music_finished() -> void:
	$Music.play()

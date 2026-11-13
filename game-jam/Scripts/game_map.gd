extends Node2D

@onready var tileset: TileMapLayer = $MapTileSet.tile_set
@onready var total_trash = $TrashTile.get_used_cells().size()
@onready var trash_cleaned = 0 # Player will be able to remove trash
@onready var money = 0

signal trash_removed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

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

func _on_spawn_timer_timeout() -> void:
	# Spawn the mobs
	pass # Replace with function body.

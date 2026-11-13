extends Node2D

@onready var tileset: TileMapLayer = $MapTileSet.tile_set
@onready var total_trash = $TrashTile.get_used_cells().size()

var zones = [1, 2, 3]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	# Spawn the mobs
	pass # Replace with function body.

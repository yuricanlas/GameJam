class_name Vacuum
extends Node2D

@export var strength : int = 1
@onready var trash_tiles: TileMapLayer = $"../../TrashTile"

signal trash_erased

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	print(trash_tiles)
	pass # Replace with function body.

func is_tile_in_tileset(coords: Vector2i) -> bool:
	var source_id = trash_tiles.get_cell_source_id(coords)

	return source_id != -1 and trash_tiles.has_source(source_id)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("vaccum_left"):
		self.visible = true
		rotation_degrees = 180
		position.x = -abs(position.x)
		
	if Input.is_action_just_pressed("vaccum_right"):
		self.visible = true
		rotation_degrees = 0
		position.x = abs(position.x)
	
	if Input.is_action_just_released("vaccum_left"):
		self.visible = false
		
	
	if Input.is_action_just_released("vaccum_right"):
		self.visible = false
	

func upgrade():
	strength += 1


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Thing Detected")
	print(body)
	if body is TileMapLayer:
		var coords = body.local_to_map(
			body.to_local(global_position)
		)
		print("Tile coordinates: ", coords)
		print(global_position)
		body.erase_cell(coords)
		
		emit_signal("trash_erased")
	

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
		rotation_degrees = 270
		position.x = -abs(position.x)
		$VacuumSound.play()
		
	if Input.is_action_just_pressed("vaccum_right"):
		self.visible = true
		rotation_degrees = 90
		position.x = abs(position.x)
		$VacuumSound.play()
	
	if Input.is_action_just_released("vaccum_left"):
		self.visible = false
		$VacuumSound.stop()
		
	
	if Input.is_action_just_released("vaccum_right"):
		self.visible = false
		$VacuumSound.stop()
		
	if visible:
		_suck()
	

func _suck() -> void:
	var center: Vector2i = trash_tiles.local_to_map(trash_tiles.to_local($Area2D.global_position))
	for x in range(-strength, strength + 1):
		for y in range(-strength, strength + 1):
			var c := center + Vector2i(x, y)
			if trash_tiles.get_cell_source_id(c) != -1:
				trash_tiles.erase_cell(c)
				trash_erased.emit()
	

func upgrade():
	strength += 1


func _on_vacuum_sound_finished() -> void:
	$VacuumSound.play()

extends Label

@onready var total_trash = $"../../../../TrashTile".get_used_cells().size()
@onready var trash_cleaned = 0 # Player will be able to remove trash

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(trash_cleaned) + " / " + str(total_trash)


func _on_game_map_trash_removed() -> void:
	trash_cleaned = trash_cleaned + 1
	text = str(trash_cleaned) + " / " + str(total_trash)
	pass # Replace with function body.

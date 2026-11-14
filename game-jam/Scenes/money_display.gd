extends Label

@onready var money = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Money: $" + str(money)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_map_trash_removed() -> void:
	money += 10
	text = "Money: $" + str(money)
	pass # Replace with function body.


func _on_game_map_enemy_killed() -> void:
	money += 25
	text = "Money: $" + str(money)
	pass # Replace with function body.

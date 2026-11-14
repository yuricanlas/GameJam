extends Label

@onready var player = $"../.."

func _process(_delta):
	text = "Health: " + str(player.health)

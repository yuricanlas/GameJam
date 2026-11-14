extends Label

@onready var player = $"../.."

func _process(_delta):
	text = "Speed: " + str(int(player.speed))

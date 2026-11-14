extends Label

@onready var player = $"../.."

func _process(_delta):
	if(player.health == player.max_health):
		text = "Health: " + str(player.max_health)
	else:
		text = "Health: " + str(player.health) 

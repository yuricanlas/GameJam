extends Node

const LEVELS = [1, 2, 3, 4, 5]
var level_index = 0
var level = LEVELS[level_index]

func level_up():
	level_index = level_index + 1

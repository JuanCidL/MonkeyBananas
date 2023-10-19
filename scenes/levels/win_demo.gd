extends Node2D

@onready var maze_loop = $MazeLoop

# Called when the node enters the scene tree for the first time.
func _ready():
	maze_loop.play()

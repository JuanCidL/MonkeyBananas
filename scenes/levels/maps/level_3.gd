extends Node2D
@onready var player = $Player
@onready var maze_loop = $MazeLoop

func _ready():
	Global.set_gun_picked(true)
	maze_loop.play()
	Global.set_bullet_counter(-1)

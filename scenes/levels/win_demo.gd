extends Node2D
@onready var player = $Player
@onready var maze_loop = $MazeLoop


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_gun_picked(false)
	maze_loop.play()
	Global.set_bullet_counter(1)

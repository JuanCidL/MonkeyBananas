extends Node2D
@onready var bullet = $bullet
@onready var maze_loop = $MazeLoop

func _physics_process(_delta):
	
	#maze_loop.play()
	if is_instance_valid(bullet) and bullet.global_position.y >= 272:
		bullet.tstop()

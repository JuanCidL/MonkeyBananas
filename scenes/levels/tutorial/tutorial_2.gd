extends Node2D
@onready var bullet = $bullet


func _physics_process(delta):
	if is_instance_valid(bullet) and bullet.global_position.y >= 272:
		bullet.tstop()

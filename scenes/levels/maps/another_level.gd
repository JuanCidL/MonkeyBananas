extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_gun_picked(true)
	Global.set_bullet_counter(-1)


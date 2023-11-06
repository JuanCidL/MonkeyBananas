extends RigidBody2D

@onready var damage = 10
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	animated_sprite_2d.play("default")

func get_damage():
	return damage

func time_stop():
	freeze = true
	
func resume():
	freeze = false

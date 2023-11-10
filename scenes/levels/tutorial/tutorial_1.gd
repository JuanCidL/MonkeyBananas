extends Node2D
@onready var player = $Player
@onready var plataforma_2 = $Node2D/Plataforma2
@onready var bullet = $bullet

# Called when the node enters the scene tree for the first time.
func _ready():
	player.shoot_is_enable = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var platform_position = plataforma_2.global_position.y
	if is_instance_valid(bullet):
		if bullet.global_position.y >= platform_position:
			bullet.tstop()

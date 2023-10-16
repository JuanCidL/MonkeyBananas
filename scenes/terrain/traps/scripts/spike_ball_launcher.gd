extends RigidBody2D

@export var spike_scene: PackedScene
@onready var spike_is_spawned = false
@onready var spike
@onready var marker_2d = $Marker2D
@onready var limit = 0
@export var cd = 2

func _process(delta):
	limit = limit + delta
	if limit >= cd:
		spawn_spike()
		limit = 0 
	
	
func spawn_spike():
	if (spike_is_spawned):
		spike_is_spawned = false
		spike.queue_free()
	else:
		spike_is_spawned = true
		spike = spike_scene.instantiate()
		add_child(spike)
		spike.global_position = marker_2d.global_position

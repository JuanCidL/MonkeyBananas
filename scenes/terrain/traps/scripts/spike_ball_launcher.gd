extends StaticBody2D

@export var spike_scene: PackedScene
@onready var marker_2d = $Marker2D
@onready var spawn_cd = 2
@onready var lifetime = 1.5
@onready var sc = 0
@onready var lc = 0
@onready var arr: Array[Node2D]
@onready var max_spike_count = 2
@onready var animated_sprite_2d = $Pivot/AnimatedSprite2D

func _ready():
	animated_sprite_2d.play("default")

func _process(delta):
	sc = sc+delta
	
	if not arr.is_empty():
		lc = lc + delta
	
	if sc >= spawn_cd:
		spawn_spike()
		sc = 0 
	
	if lc >= lifetime:
		lc = 0
		free_spike()
	
	if arr.size() > max_spike_count:
		free_spike()
	
func spawn_spike():
	var spike: RigidBody2D = spike_scene.instantiate()
	spike.position = marker_2d.position
	print(spike.global_position)
	add_child(spike)
	arr.push_front(spike)

func free_spike():
	if  not arr.is_empty():
		var last_spike = arr.pop_back()
		last_spike.queue_free()

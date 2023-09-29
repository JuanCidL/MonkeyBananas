extends Area2D

#@export var velocity = Vector2(300,300)
@export var speed = 300
@onready var ray_cast_2d = $RayCast2D
@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D
@export var max_bounce = 3
@export var bounce_count = 0
@onready var explotion_spawner = preload("res://scenes/player/time_stop_effect.tscn")
@onready var animated_sprite_2d = $AnimatedSprite2D





func _ready() -> void:
	#body_entered.connect(_on_body_entered)
	visible_on_screen_notifier_2d.screen_exited.connect(func(): queue_free())
	animated_sprite_2d.play("shot")
	Global.play_shot()

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	

#func _on_body_entered(_body: Node2D):
	if ray_cast_2d.is_colliding():
		var normal = ray_cast_2d.get_collision_normal()
		rotation = transform.x.bounce(normal).angle()
		bounce_count +=1
		#get_parent().find_child("Player").bullet_is_spawned = false
	if bounce_count == max_bounce:
		queue_free()

func tstop():
	Global.play_portal()
	var explotion = explotion_spawner.instantiate()
	explotion.global_position = global_position
	get_parent().add_child(explotion)
	queue_free()
	return explotion

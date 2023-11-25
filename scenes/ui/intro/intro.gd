extends Node2D

@onready var player_animations = $PlayerAnimations
@onready var pivot: Node2D = player_animations.get_child(0)
@onready var bullet_scene = preload("res://scenes/player/bullet.tscn")
@onready var screen_center: Vector2 = get_viewport_rect().size/2
@onready var area_2d = $Area2D
@onready var bullet: Area2D
@onready var explotion = $Explotion
@onready var gpu_particles_2d: CPUParticles2D = $GPUParticles2D
@onready var canvas_modulate = $CanvasModulate

func _ready():
	area_2d.connect("area_entered", explode)
	canvas_modulate.color = Color(0,0,0)
	var canvas_tween = create_tween().set_parallel()
	canvas_tween.tween_property(canvas_modulate, "color:r", 1, 3)
	canvas_tween.tween_property(canvas_modulate, "color:g", 1, 3)
	canvas_tween.tween_property(canvas_modulate, "color:b", 1, 3)
	
	
func shoot():
	bullet = bullet_scene.instantiate()
	add_child(bullet)
	var bullet_spawn_pos: Vector2 = pivot.get_child(0).global_position
	
	bullet.global_position = bullet_spawn_pos
	bullet.rotation = bullet_spawn_pos.direction_to(screen_center).angle()

func explode(body: Area2D):
	gpu_particles_2d.emitting = true
	if body.has_method("tstop"):
		bullet.queue_free()
	explotion.show()
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR).set_parallel()
	var exp_tween = create_tween()
	exp_tween.tween_property(explotion, "scale", Vector2(800, 800), 1)
	tween.tween_property(player_animations, "position", Vector2(600, player_animations.position.y+40), 1)
	tween.tween_property(player_animations, "rotation", 30, 1)
	await tween.finished
	Global.show_intro = true
	queue_free()

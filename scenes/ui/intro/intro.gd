extends Node2D

@onready var player_animations = $PlayerAnimations
@onready var playback: AnimationNodeStateMachinePlayback = player_animations.get_child(2).get("parameters/playback")
@onready var pivot: Node2D = player_animations.get_child(0)
@onready var bullet_scene = preload("res://scenes/player/bullet.tscn")
@onready var screen_center: Vector2 = get_viewport_rect().size/2
@onready var area_2d = $Area2D
@onready var bullet: Area2D
@onready var explotion = $Explotion
@onready var gpu_particles_2d: CPUParticles2D = $GPUParticles2D

func _ready():
	
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	playback.travel("run")
	tween.tween_property(player_animations, "position", Vector2(360, player_animations.position.y), 3)
	await tween.finished
	playback.travel("idle")
	pivot.scale.x *= -1
	await get_tree().create_timer(1.0).timeout
	#playback.travel("shot")
	bullet = bullet_scene.instantiate()
	area_2d.connect("area_entered", explode)
	var bullet_spawn_pos: Vector2 = pivot.get_child(0).global_position
	
	bullet.global_position = bullet_spawn_pos
	bullet.rotation = bullet_spawn_pos.direction_to(screen_center).angle()
	add_child(bullet)

func explode(body: Area2D):
	gpu_particles_2d.emitting = true
	if body.has_method("tstop"):
		bullet.queue_free()
	explotion.show()
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR).set_parallel()
	var exp_tween = create_tween()
	exp_tween.tween_property(explotion, "scale", Vector2(800, 800), 1)
	tween.tween_property(player_animations, "position", Vector2(800, player_animations.position.y+40), 1)
	tween.tween_property(player_animations, "rotation", 80, 1)
	await tween.finished
	queue_free()

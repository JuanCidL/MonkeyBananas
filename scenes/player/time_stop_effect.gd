extends Area2D

@onready var effect = $Effect
@onready var gpu_particles_2d = $GPUParticles2D
@onready var tween = create_tween()#.set_parallel(true)
@onready var final_scale = Vector2(80, 80)
@onready var dt = 1.0
@onready var myself = self

func _ready():
	gpu_particles_2d.set("emitting", true)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(effect, "scale", final_scale, dt)
	tween.parallel().tween_property($TextureProgressBar, "modulate:a", 0.5, dt)
	await tween.finished
	connect("body_entered", _on_body_entered)
	for body in get_overlapping_bodies():
		stop(body)
	create_tween().tween_property($TextureProgressBar, "value", 0, 3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(3).timeout
	if myself != null:
		destroy()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		effect.visible = !get_tree().paused

func _on_body_entered(stopeable: Node2D):
	print(stopeable.name)
	stop(stopeable)
	

func stop(body: Node2D):
	if body.has_method("time_stop"):
		body.call_deferred("time_stop")
		Global.stop_group.emit(body)
	
		
func resume(body: Node2D):
	if body.has_method("resume"):
		body.resume()

func destroy():
	var bodies = get_overlapping_bodies()
	monitoring = false
	monitorable = false
	for body in bodies:
		resume(body)
	Global.unstop_group.emit()
	queue_free()

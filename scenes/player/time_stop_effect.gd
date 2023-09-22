extends Node2D

@onready var effect = $Effect
@onready var gpu_particles_2d = $GPUParticles2D
@onready var tween = create_tween()#.set_parallel(true)
@onready var final_scale = Vector2(80, 80)
@onready var dt = 1.0

func _ready():
	gpu_particles_2d.set("emitting", true)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(effect, "scale", final_scale, dt)

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		effect.visible = !get_tree().paused

extends AnimatableBody2D


@export var movement : Vector2
@export_range(1, 6) var timing: float = 1.0

@onready var tween: Tween

func _ready():
	setup_tween()

func setup_tween():
	tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_loops().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", movement, timing).as_relative()
	tween.tween_property(self, "position", -movement, timing).as_relative()

func time_stop():
	tween.pause()

func resume():
	tween.play()

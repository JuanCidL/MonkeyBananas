extends AnimatableBody2D


@export var movement : Vector2
@export_range(1, 5) var timing: float = 1.0

func _ready():
	var tween= create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_loops().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", movement, timing).as_relative()
	tween.tween_property(self, "position", -movement, timing).as_relative()

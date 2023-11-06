extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_enter)
	
func _on_body_enter(body: Node2D):
	if body.has_method("receive_damage"):
		body.receive_damage(100)

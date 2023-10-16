extends Node

@onready var children
@onready var is_stopped = false

func _ready():
	Global.stop_group.connect(time_stop)
	Global.unstop_group.connect(resume)
	children = get_children()
	

func time_stop(node: Node2D):
	if node in children:
		is_stopped = true
		for child in children:
			if child.has_method("time_stop"):
				child.time_stop()

func resume():
	if is_stopped:
		for child in children:
			if child.has_method("resume"):
				child.resume()
	

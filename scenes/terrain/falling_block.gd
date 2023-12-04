extends RigidBody2D
@onready var stopped = false
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var area_2d = $Area2D
@onready var falling =false
# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.connect("body_entered",_on_body_enter) # Replace with function body.


func _on_body_enter(body:Node2D):
	if not stopped:
		set_deferred('freeze',false)
		falling=true
	
func time_stop():
	set_deferred('freeze',true)
	stopped=true
func resume():
	stopped=false
	if falling:
		set_deferred('freeze',false)
		

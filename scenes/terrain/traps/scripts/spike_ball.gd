extends RigidBody2D

func time_stop():
	freeze = true
	
func resume():
	freeze = false

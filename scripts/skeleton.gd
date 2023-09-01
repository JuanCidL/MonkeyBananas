extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animated_sprite = $AnimatedSprite2D
var direction = 1
const SPEED = 150.0
var collisionShape: CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	collisionShape = $CollisionShape2D
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var velocity = Vector2(SPEED * direction * delta, 0)
	_animated_sprite.play("walk")
	move_and_collide(velocity)
	
	if is_on_wall():
		direction *= -1
		collisionShape.scale.x *= -1

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() # Replace with function body.

extends CharacterBody2D

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var direction = 1
const SPEED = 3000.0
@onready var collisionShape: CollisionShape2D
@onready var pivot = $Pivot
@onready var wall_ray = $Pivot/WallRay
@onready var floor_ray = $Pivot/FloorRay
@onready var animated_sprite_2d = $Pivot/AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	collisionShape = $CollisionShape2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	velocity.x = SPEED * direction * delta
	
	if not is_on_floor():
		velocity.y +=  gravity*delta
	
	if wall_ray.is_colliding() or (not floor_ray.is_colliding() and is_on_floor()):
		direction *= -1
		pivot.scale.x *= -1
		

		
	move_and_slide()
	animated_sprite_2d.play("walk")
	
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() # Replace with function body.
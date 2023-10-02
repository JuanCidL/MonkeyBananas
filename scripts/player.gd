extends CharacterBody2D


@export var speed = 300.0
@export var jump_speed = -400.0
@export var acceleration = 800
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $Pivot/Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $Pivot


@onready var bullet_spawn: Marker2D = $Pivot/BulletSpawn
@export var bullet_scene: PackedScene
@onready var bullet_is_spawned : bool = false
@onready var bullet

@onready var explotion_is_spawned: bool = false
@onready var explotion

@onready var jump_sound = $JumpSound



func _ready():
	animation_tree.set("active", true)

func _physics_process(delta):
	var move_input = Input.get_axis("move_left", "move_right")
	
	if not is_on_floor():
		velocity.y += gravity*delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		jump_sound.play()
		velocity.y = jump_speed
		
		
		
	velocity.x = move_toward(velocity.x, speed * move_input, acceleration * delta)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("bullet") and not bullet_is_spawned:
		playback.travel("shoot")
		#fire()
		return
	
	if Input.is_action_just_pressed("time_stop"):
		tstop()
	
	# animation
	
	if velocity.x != 0 and move_input:
		pivot.scale.x = move_input
	
	
	if is_on_floor():
		if abs(velocity.x) > 5 or move_input:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")
			
func fire():
	if not bullet_is_spawned:
		if explotion_is_spawned:
			explotion.queue_free()
			explotion_is_spawned = false
		bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = bullet_spawn.global_position
		bullet.rotation = bullet_spawn.global_position.direction_to(get_global_mouse_position()).angle()
		bullet_is_spawned = true
		
		bullet.tree_exited.connect(func(): bullet_is_spawned = false)

func tstop():
	if bullet_is_spawned:
		explotion = bullet.tstop()
		explotion_is_spawned = true

## Llama al setter de win
func on_win_condition():
	Global.set_win(true)
	Global.win = false
  
  

""""
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
"""

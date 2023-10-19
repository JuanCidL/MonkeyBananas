extends CharacterBody2D


@export var speed = 250.0
@export var jump_speed = -400.0
@export var acceleration = 800
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $Pivot/Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $Pivot
@onready var hitbox = $Hitbox


@onready var bullet_spawn: Marker2D = $Pivot/BulletSpawn
@export var bullet_scene: PackedScene
@onready var bullet_is_spawned : bool = false
@onready var bullet

@onready var explotion: Area2D

var health = 50
@onready var input_enabled = true
@onready var is_invulnerable = false
@onready var vulnerability = $Vulnerability
@onready var is_hit = false
@onready var horizontal_knockback_speed = -200
@onready var vertical_knockback_speed = -100
@onready var input = $Input

@onready var jump_sound = $JumpSound

func _ready():
	animation_tree.set("active", true)
	hitbox.connect("body_entered", _on_body_enter)
	Global.set_alive(true)

func _physics_process(delta):
	
	# GRAV
	if not is_on_floor():
		velocity.y += gravity*delta
		
	# INPUTS
	if input_enabled:
		var move_input = Input.get_axis("move_left", "move_right")
	
		if is_on_floor() and Input.is_action_just_pressed("jump"):
			jump_sound.play()
			velocity.y = jump_speed
			
		velocity.x = move_toward(velocity.x, speed * move_input, acceleration * delta)

			
		if Input.is_action_just_pressed("bullet") and not bullet_is_spawned:
			playback.travel("shoot")
			return
		
		if Input.is_action_just_pressed("time_stop"):
			tstop()
		
		# ANIMATIONS
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
		
	move_and_slide()
	
	
	
	
	# animation
	
	
			
func fire():
	if not bullet_is_spawned:
		if explotion != null:
			explotion.destroy()

			
		bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = bullet_spawn.global_position
		bullet.rotation = bullet_spawn.global_position.direction_to(get_global_mouse_position()).angle()
		bullet_is_spawned = true
		
		bullet.tree_exited.connect(func(): bullet_is_spawned = false)

func tstop():
	if bullet_is_spawned:
		explotion = bullet.tstop()

## Llama al setter de win
func on_win_condition():
	Global.set_win(true)
	Global.win = false
  
func get_health():
	return health

func set_health(n):
	health = n

func do_knockback( normal ):
	velocity.y = vertical_knockback_speed
	velocity.x = normal[0] * horizontal_knockback_speed
	# tween interpolar desde horizontal hasta 0
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(self, "velocity:x", 0.0, 0.4)
	
func start_invulnerable():
	vulnerability.start()
	is_invulnerable = true

func hit(damage, normal):
	if is_invulnerable:
		return
	receive_damage(damage)
	do_knockback(normal)
	

func check_alive():
	if (health == 0 or health < 0):
		health = 0
		await die()
		Global.set_alive(false)
		
func die():
	playback.travel("damage")
	set_physics_process(false)
	var tween = create_tween()
	await tween.tween_property(sprite, "modulate:a", 0, 2).finished
	return 0
		
func block_input():
	input.start()
	input_enabled = false
	
func receive_damage( damage):
	start_invulnerable()
	block_input()
	playback.travel("damage")
	var new_health = get_health() - damage
	set_health(new_health)
	print('Ouch! ',  damage, ' Cur: ', health)
	check_alive()

func _on_vulnerability_timeout():
	is_invulnerable = false

func _on_input_timeout():
	input_enabled = true

func _on_body_enter(node: Node2D):
	if node.has_method("get_damage"):
		var dmg = node.get_damage()
		var node_pos = node.global_position
		var normal = (node_pos - global_position).normalized()
		hit(dmg, normal)

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




extends MarginContainer

@onready var select_buttons = $SelectButtons
@onready var play = $SelectButtons/Play
@onready var credits = $SelectButtons/Credits
@onready var exit = $SelectButtons/Exit
@onready var buttons: Array = Array()
@onready var tittle = $SelectButtons/Tittle
const intro_scene = preload("res://scenes/ui/intro/intro.tscn") 
@onready var intro: Node2D

const demo = preload("res://scenes/levels/maps/Mapa 1.tscn")

func _ready():
	buttons.append(play)
	buttons.append(credits)
	buttons.append(exit)
	
	for button in buttons:
		button.hide()
		button.modulate.a = 0
	
	play.pressed.connect(_on_play_pressed)
	credits.pressed.connect(_on_credits_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
	if not Global.show_intro:
		intro = intro_scene.instantiate()
		add_child(intro)
		intro.connect("tree_exited", init_menu)
	else:
		init_menu()

func _process(_delta):
	if Input.is_action_just_pressed("skip_intro") and not Global.show_intro:
		Global.show_intro = true
		intro.queue_free()

func _on_play_pressed():
	Global.play_confirm()
	get_tree().change_scene_to_packed(demo)
	

func _on_credits_pressed():
	Global.play_confirm()
	get_tree().change_scene_to_file("res://scenes/ui/credits.tscn")

func _on_exit_pressed():
	await Global.play_back()
	get_tree().quit()
	
func init_menu():
	for button in buttons:
		var tween = create_tween()
		button.show()
		tween.tween_property(button, "modulate:a", 1, 0.5)
		await tween.finished 
		

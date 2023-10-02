extends MarginContainer

@onready var select_buttons = $SelectButtons
@onready var play = $SelectButtons/Play
@onready var credits = $SelectButtons/Credits
@onready var exit = $SelectButtons/Exit
@onready var intro = $Intro
@onready var buttons: Array = Array()
@onready var tittle = $SelectButtons/Tittle

const demo = preload("res://scenes/levels/win_demo.tscn")

func _ready():
	buttons.append(play)
	buttons.append(credits)
	buttons.append(exit)
	
	for button in buttons:
		button.hide()
		button.modulate.a = 0
	
	intro.show()

	play.pressed.connect(_on_play_pressed)
	credits.pressed.connect(_on_credits_pressed)
	exit.pressed.connect(_on_exit_pressed)
<<<<<<< HEAD
	intro.connect("tree_exited", init_menu)
=======
	
>>>>>>> 91d96b645b3bc5eafc968e47c9783b53102407de

func _on_play_pressed():
	Global.play_confirm()
	get_tree().change_scene_to_packed(demo)
	

func _on_credits_pressed():
	Global.play_confirm()

func _on_exit_pressed():
	await Global.play_back()
	get_tree().quit()
	
func init_menu():
	for button in buttons:
		var tween = create_tween()
		button.show()
		tween.tween_property(button, "modulate:a", 1, 0.5)
		await tween.finished 
		

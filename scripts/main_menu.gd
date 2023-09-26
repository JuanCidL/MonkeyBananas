extends MarginContainer

@onready var select_buttons = $SelectButtons
@onready var play = $SelectButtons/Play
@onready var credits = $SelectButtons/Credits
@onready var exit = $SelectButtons/Exit
@onready var intro = $Intro
@onready var buttons: Array = Array()
@onready var tittle = $Tittle

const demo = preload("res://scenes/levels/win_demo.tscn")

func _ready():
	buttons.append(play)
	buttons.append(credits)
	buttons.append(exit)
	
	for button in buttons:
		button.hide()
	
	select_buttons.hide()
	intro.show()
	play.pressed.connect(_on_play_pressed)
	exit.pressed.connect(_on_exit_pressed)
	intro.connect("tree_exited", func(): 
		await create_tween().tween_property(tittle, "position", Vector2(tittle.position.x, 120), 0.5).finished
		tittle.reparent(select_buttons)
		select_buttons.move_child(tittle, 0)
		for button in buttons:
			button.show()
			get_tree().create_timer(0.5)
		select_buttons.show())

func _on_play_pressed():
	get_tree().change_scene_to_packed(demo)
	
func _on_exit_pressed():
	get_tree().quit()

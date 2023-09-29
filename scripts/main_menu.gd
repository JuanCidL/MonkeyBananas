extends MarginContainer

@onready var play = $SelectButtons/Play
@onready var credits = $SelectButtons/Credits
@onready var exit = $SelectButtons/Exit

const demo = preload("res://scenes/levels/win_demo.tscn")

func _ready():
	play.pressed.connect(_on_play_pressed)
	credits.pressed.connect(_on_credits_pressed)
	exit.pressed.connect(_on_exit_pressed)
	

func _on_play_pressed():
	Global.play_confirm()
	get_tree().change_scene_to_packed(demo)
	

func _on_credits_pressed():
	Global.play_confirm()

func _on_exit_pressed():
	await Global.play_back()
	get_tree().quit()

extends MarginContainer

@onready var play = $SelectButtons/Play
@onready var credits = $SelectButtons/Credits
@onready var exit = $SelectButtons/Exit

const demo = preload("res://scenes/levels/demo_level.tscn")

func _ready():
	play.pressed.connect(_on_play_pressed)
	exit.pressed.connect(_on_exit_pressed)

func _on_play_pressed():
	get_tree().change_scene_to_packed(demo)
	
func _on_exit_pressed():
	get_tree().quit()

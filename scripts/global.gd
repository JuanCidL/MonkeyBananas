extends Node
@onready var confirm = $Confirm
@onready var back = $Back
@onready var shot = $Shot
@onready var portal = $Portal


## Escena del menu para tenerla siempre cargada
var main_menu = preload("res://scenes/ui/main_menu.tscn")
var show_intro: bool = false

## Estado de vida del personaje
var is_alive: bool = true

## Señal para comunicar los cambios de la variable is_alive
signal life_state_changed(new_state: bool)

## Setter de la variable is_alive
func set_alive(new_state: bool):
	is_alive = new_state
	emit_signal("life_state_changed", new_state)


#### Variable que representa si el jugador paso el nivel ###
var win: bool = false

## Señal para comunicar los cambios de la variable win
signal win_condition(value: bool)

## Setter de la variable de win
func set_win(value: bool):
	win = value
	emit_signal("win_condition", win)
	
## Signal timestop group
signal stop_group(group: Node2D)
signal unstop_group

	
func play_confirm():
	confirm.play()

func play_back():
	back.play()
	await back.finished
	
func play_shot():
	shot.play()

func play_portal():
	portal.play()
	

extends Node
@onready var confirm = $Confirm
@onready var back = $Back
@onready var shot = $Shot
@onready var portal = $Portal
@onready var death = $Death
@onready var item_collect = $Item_Collect
@onready var hit = $Hit
@onready var bullet_counter = -1
@onready var has_gun = false

signal bullet_notifier(bullet_counter: int)
signal gun_notifier(value: bool)

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
	
signal lifebar(health: int)


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

func play_hit():
	hit.play()

func play_death():
	death.play()
	
func play_item_collect():
	item_collect.play()

'''
Setter of param bullet_counter
	param n: Int. Numbers of bullets
'''
func set_bullet_counter(n):
	bullet_counter = n
	bullet_notifier.emit(n)
	
'''
Getter of param bullet_counter
	param n: Int. Numbers of bullets
'''
func get_bullet_counter():
	return bullet_counter
	
"""
State getter of gun in player
	return -> boolean: true if player has gun, false if no.
"""
func get_gun_picked() -> bool:
	return has_gun

"""
State getter for gun state
	param value: boolean state to change
	return -> void
"""
func set_gun_picked(value: bool) -> void:
	has_gun = value
	gun_notifier.emit(value)

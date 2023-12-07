extends Control

@onready var buttons = $Right/Buttons
@onready var animation_tree = $Left/Player/PlayerAnimations/AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var sprite = $Left/Player/PlayerAnimations/Pivot/Sprite2D
@onready var label = $Label

## Se crean los botones
var restart = Button.new()
var resume = Button.new()
var next_level = Button.new()
var main_menu = Button.new()

## Variable para ver si ya se agregó el boton de next level
var nl_added = false
## Escena del siguiente nivel
@onready var n_lvl: PackedScene = Global.get_next_level()


# Called when the node enters the scene tree for the first time.
func _ready():
	## Se oculta la visibilidad ya que el menu de pausa aparece al llamarlo con "p"
	label.hide()
	hide()
	
	
	## Se les asigna nombre a los botones
	resume.text = "Resume"
	restart.text = "Restart"
	next_level.text = "Next Level"
	main_menu.text = "Main Menu"
	## Se les añade la funcion callback para la señal al presionar los botones
	resume.pressed.connect(_on_resume_pressed)
	restart.pressed.connect(_on_restart_pressed)
	next_level.pressed.connect(_on_next_level_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)
	
	## Se añaden los botones por defecto del menu de pausa
	buttons.add_child(resume)
	buttons.add_child(restart)
	buttons.add_child(main_menu)
	
	
	## Se conecta la señal de condicion de victoria a un callback
	Global.win_condition.connect(_on_win_condition)
	Global.life_state_changed.connect(_on_die)

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		## Si se presiona p se muestra el menu y se pausa el juego
		## Si el juego está en pausa, se oculta el menu y se quita la pausa
		_pause()

func _pause():
	visible = not visible
	get_tree().paused = not get_tree().paused

######## Funciones de callback ########
func _on_resume_pressed():
	Global.play_confirm()
	_pause()
	
func _on_restart_pressed():
	Global.play_back()
	get_tree().reload_current_scene()
	_pause()
	
func _on_next_level_pressed():
	if n_lvl:
		Global.play_confirm()
		get_tree().change_scene_to_packed(n_lvl)
		_pause()

func _on_main_menu_pressed():
	Global.play_back()
	get_tree().change_scene_to_packed(Global.main_menu)
	_pause()

func _on_win_condition(value: bool):
	if value and not nl_added:
		## Se agrega el boton de siguiente nivel y se posiciona en lo mas alto
		## tambien se elimina el boton de resume
		buttons.remove_child(resume)
		if not n_lvl:
			n_lvl = Global.get_next_level()
		buttons.add_child(next_level)
		buttons.move_child(next_level, 0)
		nl_added = true
		
		## Se cambia la animacion del sprite de pausa
		playback.travel("run")
		## Se pausa el nivel
		_pause()

func _on_die(is_alive: bool):
	if not is_alive:
		buttons.remove_child(resume)
		show()
		playback.travel("damage")
		label.show()
		get_tree().paused = true
		#var value = 0
		#while true:
		#	var dt = get_process_delta_time()
		#	value = value + dt
		#	sprite.modulate.r = sin(value)
			

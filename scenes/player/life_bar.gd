extends Control

@onready var life_bar = $LifeBar

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.lifebar.connect(_set_health)
	
func _set_health(healt: int):
	life_bar.value = healt

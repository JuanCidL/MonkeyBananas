extends Control

@onready var life_bar = $LifeBar
@onready var label = $Bullet/Label
@onready var gun = $Gun

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.lifebar.connect(_set_health)
	Global.bullet_notifier.connect(_update_bullets)
	Global.gun_notifier.connect(_change_gun_visibility)

func _set_health(healt: int):
	life_bar.value = healt

func _update_bullets(count):
	if count < 0:
		label.rotation = deg_to_rad(90)
		label.text = str(8)
		return;
	label.text = str(count)

func _change_gun_visibility(value: bool):
	if value:
		gun.show()
	else:
		gun.hide()

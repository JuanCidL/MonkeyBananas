extends Area2D
@export var default_bullets = 3

func _ready():
	## Conccion con la señal que emite que se toco la caja
	body_entered.connect(_on_body_entered)


## Callback para cuando el jugador tocó la caja
func _on_body_entered(body: Node2D):
	Global.set_gun_picked(true)
	Global.set_bullet_counter(default_bullets + Global.get_bullet_counter())
	queue_free()

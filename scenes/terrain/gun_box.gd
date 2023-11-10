extends Area2D

func _ready():
	## Conccion con la señal que emite que se toco la caja
	body_entered.connect(_on_body_entered)


## Callback para cuando el jugador tocó la caja
func _on_body_entered(body: Node2D):
	if body.has_method("set_shoot_is_enable"):
		body.set_shoot_is_enable(true)
	queue_free()

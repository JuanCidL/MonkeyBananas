extends Area2D
@export var default_bullets = 3

func _ready():
	## Conccion con la señal que emite que se toco la caja
	body_entered.connect(_on_body_entered)


## Callback para cuando el jugador tocó la caja
func _on_body_entered(body: Node2D):
	#Se pregunta si el body puede disparar
	if body.has_method("set_shoot_is_enable"):
		body.set_shoot_is_enable(true)
		#Se pregunta si no tiene balas negativas (disparo infinito)
		if Global.get_bullet_counter() >= 0:
			#Le sumo n balas al contador de balas  
			Global.set_bullet_counter(default_bullets + Global.get_bullet_counter())
	queue_free()

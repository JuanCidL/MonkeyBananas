extends Area2D
#Cantidad de balas que suma una caja
@export var bullet_sum = 3
@onready var osc = 0


func _ready():
	## Conccion con la señal que emite que se toco la caja
	body_entered.connect(_on_body_entered)


## Callback para cuando el jugador tocó la caja
func _on_body_entered(body: Node2D):
	#Se pregunta si el body puede disparar
	if body.has_method("set_shoot_is_enable"):
		Global.play_item_collect()
		#Se pregunta si no tiene balas negativas (disparo infinito)
		if Global.get_bullet_counter() >= 0:
			#Le sumo n balas al contador de balas  
			Global.set_bullet_counter(Global.get_bullet_counter() + bullet_sum)
	queue_free()

func _physics_process(delta):
	osc = osc + delta
	if osc >= 2*PI:
		osc = 0
	position.y = position.y + sin(10*osc)

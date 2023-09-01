extends Area2D

func _ready():
	## Conccion con la señal que emite que se toco la win condition
	body_entered.connect(_on_body_entered)

## Callback para cuando el jugador entra en la win condition
func _on_body_entered(body: Node2D):
	if body.has_method("on_win_condition"):
		body.on_win_condition()

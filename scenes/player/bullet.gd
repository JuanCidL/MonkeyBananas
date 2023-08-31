extends Area2D


@export var speed = 300

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_body_entered(_body: Node2D):
	queue_free()

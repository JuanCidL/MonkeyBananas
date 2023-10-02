extends CanvasLayer
@onready var whole_loop = $WholeLoop



# Called when the node enters the scene tree for the first time.
func _ready():
	whole_loop.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

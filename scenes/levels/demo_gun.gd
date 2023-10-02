extends CanvasLayer
@onready var whole_loop = $WholeLoop



# Called when the node enters the scene tree for the first time.
func _ready():
	whole_loop.play()

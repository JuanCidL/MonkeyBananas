extends CanvasLayer
@onready var maze_loop = $MazeLoop



# Called when the node enters the scene tree for the first time.
func _ready():
	maze_loop.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends CanvasLayer
@onready var rich_text_label = $RichTextLabel
@onready var button = $Button

@export var scroll_start = 3
@onready var scroll_bar: VScrollBar = rich_text_label.get_v_scroll_bar()
@onready var parallax_layer = $ParallaxBackground/ParallaxLayer

signal scroll_completed

var _completed = false
var speed = 1
var _scroll_delta = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	button.hide()
	rich_text_label.connect("meta_clicked", _richtextlabel_on_meta_clicked)
	scroll_bar.step = 0.01
	scroll_completed.connect(_show_back)
	button.connect("pressed", _to_main_menu)
	
	

# This assumes RichTextLabel's `meta_clicked` signal was connected to
# the function below using the signal connection dialog.
func _richtextlabel_on_meta_clicked(meta):
	# `meta` is not guaranteed to be a String, so convert it to a String
	# to avoid script errors at run-time.
	OS.shell_open(str(meta))

func _process(delta):
	if not _completed:
		if Input.is_action_pressed("jump"):
			speed = 10
		else:
			speed = 1
		
		if _scroll_delta < scroll_start:
			_scroll_delta += delta * speed
		else:
			var old_scroll_value = scroll_bar.value
			scroll_bar.value += 0.1 * speed
			parallax_layer.motion_offset.y -= 0.05 * speed
			if !_completed and (scroll_bar.value == old_scroll_value):
				_completed = true
				scroll_completed.emit()

func _show_back():
	button.show()


func _to_main_menu():
	get_tree().change_scene_to_packed(Global.main_menu)

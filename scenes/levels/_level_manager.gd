extends MarginContainer

@onready var levels: Array[PackedScene] = Global.levels
@onready var v_box_container = $CenterContainer/PanelContainer/VBoxContainer
@export var levels_per_row: int = 4 
const screenshot_path = "res://assets/screenshots/"

# Called when the node enters the scene tree for the first time.
func _ready():
	if (len(levels)):
		var row_counter: int = 0 # Contador de niveles por fila
		var level_counter: int = 0
		var error_img = load("res://assets/screenshots/-1.png")
		v_box_container.add_theme_constant_override("separation", 15)
	
		## Row properties
		var row: HBoxContainer = HBoxContainer.new()
		row.add_theme_constant_override("separation", 20)
		row.alignment = BoxContainer.ALIGNMENT_CENTER
		v_box_container.add_child(row)
		for level in levels:
			if row_counter>levels_per_row-1:
				row_counter = 0
				row = HBoxContainer.new()
				row.add_theme_constant_override("separation", 20)
				row.alignment = BoxContainer.ALIGNMENT_CENTER
				v_box_container.add_child(row)
			if level:
				level_counter += 1
				row_counter += 1
				var level_button: Button = Button.new()
				
				## Screenshots manage
				var screenshot: CompressedTexture2D
				if (ResourceLoader.exists(screenshot_path+str(level_counter-1)+".png")):
					screenshot = load(screenshot_path+str(level_counter-1)+".png")
				else:
					screenshot = error_img
				
				#screenshot.resize(50, 50)
				#var texture: Texture2D = ImageTexture.create_from_image(screenshot)
				level_button.icon = screenshot
					
				_set_level(level_button, level)
				row.add_child(level_button)
				
func _set_level(button: Button, level: PackedScene):
	button.pressed.connect(func():
		Global.update_idx_lvl(levels.find(level))
		Global.play_confirm()
		get_tree().change_scene_to_packed(level)
	);

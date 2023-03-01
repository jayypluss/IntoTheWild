extends Node3D

@onready var light: SpotLight3D = $SpotLight3D
@onready var colors: Array[Color] = [Color('ffffff'), Color('ff0000'), Color('00ff00'), Color('0000ff')]
@onready var next_color_index = 1

func _ready():
	set_color()

func trigger1():
	next_color_index = 1
	if light and light.visible:
		if light.light_color.to_html(false) != 'ffffff':
			set_color(Color('#ffffff'))
		elif light.light_color.to_html(false) == 'ffffff':
			toggle_light()
	elif light and !light.visible:
		toggle_light()

func trigger2():
	if light and light.visible:
		if light.light_color.to_html(false) != colors[next_color_index].to_html(false):
			set_color(colors[next_color_index])
			if next_color_index >= colors.size()-1:
				next_color_index = 1
			else:
				next_color_index += 1
		elif light.light_color.to_html(false) != colors[next_color_index].to_html(false):
			toggle_light()
	elif light and !light.visible:
		toggle_light()
		
func toggle_light():
	if light and light.visible:
		light.hide()
	elif light and !light.visible:
		light.show()

func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.has_method('pick_item'):
		body.pick_item(self)
	if light and !light.visible:
		light.show()

func set_color(color: Color = Color('#ffffff')):
	light.light_color = color

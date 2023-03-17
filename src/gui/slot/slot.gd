extends PanelContainer


signal slot_clicked(index: int, button: int, double_click: bool)

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
#@onready var quantity_label: Label = $Label


const slot_bg_selected = preload('res://assets/gui/slot_bg_selected.tres')


func set_slot_datum(slot_datum: BluepintSlotDatum) -> void:
	var blueprint_data = slot_datum.item_data
	texture_rect.texture = blueprint_data.texture
	tooltip_text = '%s\n%s' % [blueprint_data.name, blueprint_data.description]
		
#		if slot_datum.quantity > 1:
#			quantity_label.text = 'x%s' % slot_data.quantity
#			quantity_label.show()



func _on_gui_input(event: InputEvent):
	if (event is InputEventMouseButton
		and (event.button_index == MOUSE_BUTTON_LEFT
		or event.button_index == MOUSE_BUTTON_RIGHT)
		and event.is_pressed()):
			slot_clicked.emit(get_index(), event.button_index, event.double_click)
			add_theme_stylebox_override('panel', slot_bg_selected)

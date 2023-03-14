extends PanelContainer

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
#@onready var quantity_label: Label = $Label


func set_slot_datum(slot_datum: BluepintSlotDatum) -> void:
	var blueprint_data = slot_datum.item_data
	texture_rect.texture = blueprint_data.texture
	tooltip_text = '%s\n%s' % [blueprint_data.name, blueprint_data.description]
		
#		if slot_datum.quantity > 1:
#			quantity_label.text = 'x%s' % slot_data.quantity
#			quantity_label.show()

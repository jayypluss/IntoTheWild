extends PanelContainer
class_name BlueprintsInventory


@onready var blueprints_grid: ItemList = $BlueprintsGrid

@export var available_blueprints: Array[Blueprint]

func _ready() -> void:
	populate_item_grid(available_blueprints)

func populate_item_grid(blueprints: Array[Blueprint]) -> void:
	for blueprint in blueprints:
		blueprints_grid.add_item(blueprint.name, blueprint.texture)
		#var slot = Slot.instantiate()
		#blueprints_grid.add_child(slot)
		
		#slot.slot_clicked.connect(func(_index, _button, _double_click):
			#for child in blueprints_grid.get_children(false):
				#child.remove_theme_stylebox_override('panel')
		#)
#
		#slot.slot_clicked.connect(blueprint.on_slot_clicked)

		#if blueprint:
			#slot.set_slot_datum(blueprint)

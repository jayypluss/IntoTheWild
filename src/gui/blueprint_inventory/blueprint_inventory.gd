extends PanelContainer
class_name BlueprintsInventory


@onready var blueprints_grid: ItemList = $BlueprintsGrid

@export var available_blueprints: Array[Blueprint]

func _ready() -> void:
	populate_item_grid(available_blueprints)

func populate_item_grid(blueprints: Array[Blueprint]) -> void:
	for blueprint in blueprints:
		blueprints_grid.add_item(blueprint.name, blueprint.texture)

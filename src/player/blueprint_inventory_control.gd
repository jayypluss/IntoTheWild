extends Control
class_name BlueprintInventoryControl


signal chose_blueprint()

@onready var player: Player
@onready var blueprint_inventory: BlueprintsInventory = $BlueprintsInventory

var blueprint_mode:= false

func _ready():
	player = self.owner
	blueprint_inventory.blueprints_grid.item_activated.connect(func(index):
		hold_blueprint(blueprint_inventory.available_blueprints[index])
	)

func set_player_blueprints_inventory_data(blueprints: Blueprints) -> void:
	blueprints.inventory_interact.connect(on_inventory_interact)

func on_inventory_interact(blueprints: Blueprints,
		index: int, _button: int, double_click: bool) -> void:
	var clicked_slot = blueprints.slot_data[index]
	if clicked_slot and double_click:
		await get_tree().create_timer(0.05).timeout
		hold_blueprint(clicked_slot.item_data)


func hold_blueprint(blueprint: Blueprint):
	if !player.placement_ray.is_holding_blueprint():
		var node = blueprint.body_scene
		var instance = node.instantiate()
		instance.visible = false
		player.placement_ray.add_child(instance)
		player.placement_ray.setup_blueprint()
		chose_blueprint.emit()
		close()

func close():
	set_blueprints_inventory_visibility(false)
	blueprint_mode = false

func toggle_blueprint_visibility() -> bool:
	set_blueprints_inventory_visibility(!blueprint_inventory.visible)
	return blueprint_inventory.visible

func set_blueprints_inventory_visibility(new_value: bool):
	blueprint_inventory.visible = new_value
	blueprint_mode = blueprint_inventory.visible
	if blueprint_mode:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

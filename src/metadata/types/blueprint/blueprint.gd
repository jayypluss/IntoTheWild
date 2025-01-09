extends Resource
class_name Blueprint

@export var name: String = ''
@export_multiline var description: String = ''
@export var category: String = ''
@export var body_scene: PackedScene = null
@export var texture: AtlasTexture = null
@export var recipe: Array[BlueprintRecipeItem] = []

func _init(p_name = '',
	p_description = '',
	p_category = '',
	p_body_scene = null,
	p_texture = null,
	p_recipe: Array[BlueprintRecipeItem] = []):
		name = p_name
		description = p_description
		category = p_category
		body_scene = p_body_scene
		texture = p_texture
		recipe = p_recipe

extends Node3D
class_name BlueprintNode

@export var blueprint_resource: Blueprint
@export var blueprint_mesh_node: CSGMesh3D

func _init(p_blueprint_resource = null, p_blueprint_mesh_node = null):
	blueprint_resource = p_blueprint_resource
	blueprint_mesh_node = p_blueprint_mesh_node

@tool
class_name Item
extends RigidBody3D


@onready var variable_mesh_node: CSGMesh3D = $VariableMeshNode
@onready var collision: CollisionShape3D = $Collision

@export var variable_mesh: Mesh
@export var title: String

var is_player_near := false


func _init(tmp_variable_mesh: Mesh = null):
	if variable_mesh_node and (variable_mesh or tmp_variable_mesh):
		variable_mesh_node.mesh = variable_mesh if variable_mesh else tmp_variable_mesh

func _ready():
	if variable_mesh:
		variable_mesh_node.mesh = variable_mesh
		
func _enter_tree():
	apply_impulse(Vector3(0, 0, randi_range(-5,5)))

func _on_area_3d_floor_check_body_entered(_body):
	freeze = true
	collision.call_deferred('set_disabled', true)

func _on_area_3d_player_check_body_entered(_body):
	is_player_near = true

func _on_player_check_area_3d_body_exited(_body):
	is_player_near = false

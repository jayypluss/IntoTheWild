@tool
class_name Item
extends RigidBody3D


@onready var variable_mesh: CSGMesh3D = $VariableMesh
@onready var collision: CollisionShape3D = $Collision

@export var mesh: Mesh
@export var title: String

var is_player_near := false


func _init(mesh: Mesh = null):
	if mesh and variable_mesh:
		variable_mesh.mesh = mesh

func _ready():
	if variable_mesh:
		variable_mesh.mesh = mesh
	
func _enter_tree():
	apply_impulse(Vector3(0, 0, randi_range(-5,5)))

func _on_area_3d_floor_check_body_entered(body):
	freeze = true
	collision.call_deferred('set_disabled', true)

func _on_area_3d_player_check_body_entered(body):
	is_player_near = true

func _on_player_check_area_3d_body_exited(body):
	is_player_near = false
	
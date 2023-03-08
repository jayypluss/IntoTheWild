@tool
class_name Item
extends RigidBody3D


@export var mesh: Mesh
@onready var csg_mesh: CSGMesh3D = $ItemCSGMesh3D
@export var title: String
var is_player_near := false

func _init(mesh: Mesh = null):
	if mesh and csg_mesh:
		csg_mesh.mesh = mesh

func _ready():
	if csg_mesh:
		csg_mesh.mesh = mesh
	
func _process(_delta):
	if is_player_near and Input.is_action_just_pressed('collect'):
		GameState.player.obtain_item(self)
	
func _enter_tree():
	apply_impulse(Vector3(0, 0, randi_range(-5,5)))

func _on_area_3d_floor_check_body_entered(body):
	freeze = true
	$ItemCollisionShape3D.call_deferred('set_disabled', true)

func _on_area_3d_player_check_body_entered(body):
	is_player_near = true

func _on_player_check_area_3d_body_exited(body):
	is_player_near = false
	

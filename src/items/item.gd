@tool
class_name Item
extends RigidBody3D


@export var mesh: Mesh
@export var title: String

func _init(mesh: Mesh = null):
	if mesh and $Mesh:
		$Mesh.mesh = mesh

func _ready():
	if $Mesh:
		$Mesh.mesh = mesh
	
func _enter_tree():
	apply_impulse(Vector3(0, 0, randi_range(-5,5)))

func _on_area_3d_floor_check_body_entered(body):
	sleeping = true


func _on_area_3d_player_check_body_entered(body):
	if body.is_class('CharacterBody3D'):
		GameState.player.obtain_item(self)

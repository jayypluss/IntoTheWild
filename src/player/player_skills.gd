extends Node

@onready var camera: Camera3D = %Camera3D
@onready var magic: GPUParticles3D = %CameraPivot/Horizontal/Vertical/Magic

var owned_skills := ['chopping_magic']
var selected_skill := 'chopping_magic'
var is_casting_magic := false

func _process(_delta):
	print(camera.global_rotation_degrees)
	if Input.is_action_just_pressed('click'):
		is_casting_magic = true
		if magic:
			magic.emitting = true
	
	if Input.is_action_just_released('click'):
		is_casting_magic = false
		if magic:
			magic.emitting = true
			
	if magic and magic.process_material and is_casting_magic:
		magic.process_material.gravity = Vector3(
		camera.global_rotation_degrees.x*10, 
		camera.global_rotation_degrees.y*10,
		camera.global_rotation_degrees.z*10)
	

func set_selected_skill(skill_id: String):
	selected_skill = skill_id

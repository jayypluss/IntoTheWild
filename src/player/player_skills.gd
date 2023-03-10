extends Node

@onready var camera: Camera3D = %PlayerCam
@onready var particles_emitter: GPUParticles3D = %CameraPivot/Horizontal/Vertical/PlayerEmitter
@onready var hand: Node3D = %CameraPivot/Horizontal/Vertical/PlayerHand

var owned_skills := ['chopping_magic']
var selected_skill := 'chopping_magic'
var is_casting_magic := false

func _process(_delta):
	if Input.is_action_just_pressed('click') and !hand.both_hands_busy:
		is_casting_magic = true
		if particles_emitter:
			particles_emitter.emitting = true
	
	if Input.is_action_just_released('click'):
		is_casting_magic = false
		if particles_emitter:
			particles_emitter.emitting = false
	

func set_selected_skill(skill_id: String):
	selected_skill = skill_id

extends Node


@onready var player: Player
@onready var player_hud: Player

@export var walk_speed := 8.0
@export var run_speed := 13.0
@export var jump_impulse := 14.0
@export var fall_acceleration := 50.0

var paused := false
var is_jumping := false
var speed = 0
var has_jumped_sprinting := false


func _ready():
	player = self.owner


func _input(event: InputEvent) -> void:
#	if event.is_action_pressed('click'):
#		if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
#			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed('toggle_mouse_captured'):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			paused = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_viewport().set_input_as_handled()


func _physics_process(delta: float) -> void:
	hud()

	if paused: # Used to prevent movement during a cutscene.
		return

	move_and_rotate(delta)
	skills()


func hud():
	if Input.is_action_just_pressed('close'):
		player.hud.close()
	blueprints()


func blueprints():
	if Input.is_action_just_pressed('toggle_blueprint_mode'):
		var blueprint_inventory_visible = player.blueprint_inventory_interface.toggle_blueprint_mode()
		if blueprint_inventory_visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			paused = true
			player.hud.close_inventory()
		else: 
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			paused = false
		
		player.camera_pivot.paused = paused
		
	if Input.is_action_just_pressed('enter'):
		player.blueprint_inventory_interface.enter_just_pressed()


func skills():
	if Input.is_action_pressed('click'):
		player.skills.click()
	
	if Input.is_action_just_released('click'):
		player.skills.release()


func move_and_rotate(delta: float):
	# Get direction vector based checked input.
	var direction = Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_back") - Input.get_action_strength("move_front")
	)
	
	# Rotate direction based checked camera.
	var horizontal_rotation = %CameraPivot/Horizontal.global_transform.basis.get_euler().y
	direction = direction.rotated(Vector3.UP, horizontal_rotation).normalized()
	
	if direction != Vector3.ZERO: # Player is moving.
		direction = direction.normalized()
				
		if Input.is_action_pressed("sprint"): # Running.
			speed = run_speed
			if is_jumping:
				if has_jumped_sprinting:
					speed = run_speed
				else:
					speed = walk_speed
		else: # Walking.
			speed = walk_speed
			if is_jumping:
				if has_jumped_sprinting:
					speed = run_speed
				else:
					speed = walk_speed

	
	if not is_jumping and Input.is_action_pressed("jump"): # Single jump.
		player.velocity.y = jump_impulse
		is_jumping = true

		if Input.is_action_pressed("sprint"):
			has_jumped_sprinting = true
	elif player.is_on_floor() and player.get_slide_collision_count() > 0: # Reset both jumps.
		is_jumping = false
		has_jumped_sprinting = false
	
	player.velocity.y -= fall_acceleration * delta

	player.velocity.x = direction.x * speed
	player.velocity.z = direction.z * speed
	
	# Assign move_and_slide to velocity prevents the velocity from accumulating.
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector3.UP)
	player.move_and_slide()
	player.velocity = player.velocity

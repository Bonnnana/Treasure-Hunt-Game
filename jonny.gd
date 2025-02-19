extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 7

var xform : Transform3D

func _physics_process(delta: float) -> void:
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimationPlayer.play("Root_002|Root|Jump")
	elif is_on_floor() and input_dir != Vector2.ZERO:
		$AnimationPlayer.play("Root_001|Root|Run")
	elif is_on_floor() and input_dir == Vector2.ZERO:
		$AnimationPlayer.play("Root_003|Root|Idle")
		

	if Input.is_action_just_pressed("left_cam"):
		$Camera_Contorller.rotate_y(deg_to_rad(-30))
	if Input.is_action_just_pressed("right_cam"):
		$Camera_Contorller.rotate_y(deg_to_rad(30))
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = ($Camera_Contorller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if input_dir != Vector2(0,0):
		$Root.rotation_degrees.y = $Camera_Contorller.rotation_degrees.y - rad_to_deg(input_dir.angle()) - 90
		
 

	if is_on_floor():
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xform, 0.3)
	elif not is_on_floor():
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform, 0.3)
		
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# Camera follows position
	$Camera_Contorller.position = lerp($Camera_Contorller.position, position, 0.15)

func align_with_floor(normal):
	xform = global_transform
	xform.basis.y = normal
	xform.basis.x = -xform.basis.z.cross(normal)
	xform.basis = xform.basis.orthonormalized()


func _on_fall_zone_body_entered(body):
	get_tree().change_scene_to_file("res://main.tscn")

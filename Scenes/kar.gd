extends VehicleBody3D

var max_rpm = 4200
var max_torque = 700 # for whole car, divided by 4 wheels
var turn_speed = 3
var turn_amount = deg_to_rad(25)

func _physics_process(delta: float) -> void:
	$CamArm.position = position
	
	# 1.0: Gas
	# 0.0: Stop (cancel both or no input)
	# -1.0: Brake
	var dir = Input.get_action_strength("Gas") - Input.get_action_strength("Brake")
	
	# same as above for steering direction
	var steering_dir = Input.get_action_strength("Left") - Input.get_action_strength("Right")

	var RPM_LEFT = abs($wheel_back_left.get_rpm())
	var RPM_RIGHT = abs($wheel_back_right.get_rpm())
	var RPM = (RPM_LEFT + RPM_RIGHT) / 2.0 # Get average RPM
	
	var torque = dir * max_torque
	
	steering = lerp(steering, steering_dir * turn_amount, turn_speed * delta)
	engine_force = torque
	
	print(engine_force)

	if Input.is_key_pressed(KEY_SPACE):
		apply_impulse(Vector3(0, 4 * mass, 0))

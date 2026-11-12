extends VehicleBody3D

@onready var wheels: Array[VehicleWheel3D] = [$wheel_back_left, $wheel_back_right, $wheel_front_left, $wheel_front_right]
@export var EngineForce = 2250
@export var BrakingForce = 150

@export var front_wheel_grip = 1.0
@export var back_wheel_grip = 0.75
@export var back_drift_grip = 0.5

# Configuration
func _ready() -> void:
	for wheel in wheels:
		wheel.set_suspension_stiffness(70.0)
		wheel.set_suspension_travel(0.15)
		wheel.set_damping_compression(back_drift_grip)
		wheel.set_damping_relaxation(0.7)
		wheel.set_roll_influence(0.3)
		#wheel.set_suspension_rest_length(0.35)
		
		#print(
			#wheel.get_suspension_stiffness(),", ",
			#wheel.get_damping_compression(),", ",
			#wheel.get_suspension_rest_length()
		#)
	
	# set friction of tires
	
	$wheel_back_left.set_friction_slip(back_wheel_grip)
	$wheel_back_right.set_friction_slip(back_wheel_grip)
	$wheel_front_left.set_friction_slip(front_wheel_grip)
	$wheel_back_left.set_friction_slip(front_wheel_grip)
		

func _physics_process(delta: float) -> void:
	
	#brake = Input.get_action_strength("Brake") * BrakingForce
	steering = lerp(steering, deg_to_rad(35 * Input.get_action_strength("Left")) + deg_to_rad(-35 * Input.get_action_strength("Right")), 0.1)
	
	# Set gas
	if Input.is_action_pressed("Gas"):
		engine_force = Input.get_action_strength("Gas") * EngineForce
	
	# Reset gas
	elif Input.is_action_just_released("Gas"):
		engine_force = 0.0
		
	if Input.is_action_pressed("HandBrake"):
		# Set brakes
		$wheel_back_left.set_brake(BrakingForce)
		$wheel_back_right.set_brake(BrakingForce)
		
		# Set grip
		$wheel_back_left.set_friction_slip(back_drift_grip)
		$wheel_back_right.set_friction_slip(back_drift_grip)
	else:
		# Reset all
		$wheel_back_left.set_brake(0)
		$wheel_back_right.set_brake(0)
		$wheel_back_left.set_friction_slip(back_wheel_grip)
		$wheel_back_right.set_friction_slip(back_wheel_grip)
		
	if Input.is_action_pressed("Brake"):
		# Set brakes
		$wheel_front_left.set_brake(BrakingForce)
		$wheel_front_right.set_brake(BrakingForce)
	else:
		# Reset values
		$wheel_front_left.set_brake(0)
		$wheel_front_right.set_brake(0)
		
	#print(engine_force)
	print($wheel_back_left.get_skidinfo(), ", ", $wheel_back_right.get_skidinfo(), ", ", $wheel_front_left.get_skidinfo(), ", ", $wheel_front_right.get_skidinfo())
		

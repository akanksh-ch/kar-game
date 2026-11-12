extends VehicleBody3D

@onready var wheels: Array[VehicleWheel3D] = [$wheel_back_left, $wheel_back_right, $wheel_front_left, $wheel_front_right]
@export var EngineForce = 2250
@export var BrakingForce = 150

# Configuration
func _ready() -> void:
	for wheel in wheels:
		wheel.set_suspension_stiffness(125.0)
		wheel.set_suspension_travel(0.05)
		wheel.set_damping_compression(0.5)
		wheel.set_damping_relaxation(0.8)
		wheel.set_friction_slip(2.0)
		wheel.set_roll_influence(1.0)
		#wheel.set_suspension_rest_length(0.35)
		
		#print(
			#wheel.get_suspension_stiffness(),", ",
			#wheel.get_damping_compression(),", ",
			#wheel.get_suspension_rest_length()
		#)
	
	# set back tires friction to be lower than front tires
	
	$wheel_back_left.set_friction_slip(1.0)
	$wheel_back_right.set_friction_slip(1.0)
		

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("Gas"):
		engine_force = Input.get_action_strength("Gas") * EngineForce
	else:
		engine_force = 0.0
	
	#brake = Input.get_action_strength("Brake") * BrakingForce
	steering = lerp(steering, deg_to_rad(35 * Input.get_action_strength("Left")) + deg_to_rad(-35 * Input.get_action_strength("Right")), 0.1)
	
	if Input.is_action_pressed("HandBrake"):
		$wheel_back_left.set_brake(BrakingForce)
		$wheel_back_right.set_brake(BrakingForce)
	else:
		$wheel_back_left.set_brake(0)
		$wheel_back_right.set_brake(0)
		
	if Input.is_action_pressed("Brake"):
		$wheel_front_left.set_brake(BrakingForce)
		$wheel_front_right.set_brake(BrakingForce)
	else:
		$wheel_front_left.set_brake(0)
		$wheel_front_right.set_brake(0)
		
	#print($wheel_back_left.get_skidinfo(), ", ", $wheel_back_right.get_skidinfo(), ", ", $wheel_front_left.get_skidinfo(), ", ", $wheel_front_right.get_skidinfo())
		

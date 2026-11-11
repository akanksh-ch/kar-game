extends VehicleBody3D

@onready var wheels: Array[VehicleWheel3D] = [$wheel_back_left, $wheel_back_right, $wheel_front_left, $wheel_front_right]
@export var EngineForce = 1275
@export var BrakingForce = 150

# Configuration
func _ready() -> void:
	for wheel in wheels:
		wheel.set_suspension_stiffness(125.0)
		wheel.set_suspension_travel(0.05)
		wheel.set_damping_compression(0.5)
		wheel.set_damping_relaxation(0.8)
		#wheel.set_suspension_rest_length(0.35)
		
		#print(
			#wheel.get_suspension_stiffness(),", ",
			#wheel.get_damping_compression(),", ",
			#wheel.get_suspension_rest_length()
		#)

func _physics_process(delta: float) -> void:
	engine_force = Input.get_action_strength("Gas") * EngineForce
	brake = Input.get_action_strength("Brake") * BrakingForce
	steering = lerp(steering, deg_to_rad(35 * Input.get_action_strength("Left")) + deg_to_rad(-35 * Input.get_action_strength("Right")), 0.1)
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == 32: # space bar
		rotation = Vector3.ZERO
		

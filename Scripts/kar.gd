extends VehicleBody3D

@onready var wheels: Array[VehicleWheel3D] = [$wheel_back_left, $wheel_back_right, $wheel_front_left, $wheel_front_right]

# Configuration
func _ready() -> void:
	for wheel in wheels:
		wheel.set_suspension_stiffness(75.0)
		#wheel.set_damping_compression(0.5)
		#wheel.set_suspension_rest_length(0.35)
		
		print(
			wheel.get_suspension_stiffness(),", ",
			wheel.get_damping_compression(),", ",
			wheel.get_suspension_rest_length()
		)

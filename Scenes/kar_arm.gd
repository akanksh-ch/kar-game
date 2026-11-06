extends SpringArm3D

var MOUSE_SENSITIVITY = 0.1

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	top_level = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * MOUSE_SENSITIVITY
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, -10.0) # clamp up and down.
		
		rotation_degrees.y -= event.relative.x * MOUSE_SENSITIVITY
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)
		

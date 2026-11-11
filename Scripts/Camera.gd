extends Node3D

@export var SENSITIVITY = 1.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.rotation_degrees.x += event.relative.y
		self.rotation_degrees.y += -event.relative.x
		
		self.rotation_degrees.x = clampf(rotation_degrees.x, -70, 70) # 90 - 20 as spring arm is already rotated to 20 degrees by default

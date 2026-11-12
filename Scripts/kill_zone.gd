extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	print(body, "body entered")
	body.global_position = Vector3(-14.73344, 0.33, 2.75041)
	body.global_rotation = Vector3.ZERO
	body.linear_velocity = Vector3.ZERO

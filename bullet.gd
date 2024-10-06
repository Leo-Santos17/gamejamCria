extends Area2D

var travelled_distance = 0

func _physics_process(delta: float) -> void:
	const speed = 1000
	const range = 300
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction*delta*speed
	
	travelled_distance += speed*delta
	
	if travelled_distance > range:
		queue_free()

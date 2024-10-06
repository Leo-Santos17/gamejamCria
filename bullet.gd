extends Area2D

var travelled_distance = 0
var speed = 1000
var range = 300

func _physics_process(delta: float) -> void:
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction*delta*speed
	
	travelled_distance += speed*delta
	
	if travelled_distance > range:
		queue_free()

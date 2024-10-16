extends Area2D

var travelled_distance = 0
var speed = 1000
var range = 500

func _physics_process(delta: float) -> void:
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction*delta*speed
	
	travelled_distance += speed*delta
	
	if travelled_distance > range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()

extends CharacterBody2D

var life = 100
var speed = 600

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction*speed
	move_and_slide()
	

extends CharacterBody2D

const speed = 300
@onready var player = get_node("/root/Game/Player")

var damageALL : float
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*speed
	move_and_slide()
	
	

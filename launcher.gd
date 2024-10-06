extends CharacterBody2D

const speed = 50
@onready var player = get_node("/root/Game/Player")

var damageALL : float
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	var distanceTOplayer = global_position.direction_to(player.global_position)*1.1
	velocity = direction*speed
	print(distanceTOplayer)
	print(direction)
	#if distance > 300:
	#	move_and_slide()
	#	print("Correndo")
	#else:
	#	print("Pow Pow")
	
	
	

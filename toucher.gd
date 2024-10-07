extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")

const speed = 300
var life = 3
const limitDistance = 100
var hurtDamage = 1

func _ready() -> void:
	$StatusLife.max_value = life
	status()

func _physics_process(delta: float) -> void:
	moveMob()

func moveMob():
	var direction = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	velocity = direction*speed
	checkDistance(distance)

func checkDistance(distance):
	if distance > limitDistance:
		move_and_slide()

func take_damage():
	#print("Dano em Toucher")
	life-=hurtDamage*player.damageMulti
	status()
	if life<=0:
		queue_free()

func status():
	$StatusLife.value = life

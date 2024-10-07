extends CharacterBody2D

const speed = 300
var life = 3
@onready var player = get_node("/root/Game/Player")
var damageALL = 1

func _ready() -> void:
	max_life(life)

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	velocity = direction*speed
	if distance > 100:
		move_and_slide()

func max_life(life):
	$ProgressBar.max_value = life
	$ProgressBar.value = life

func take_damage():
	#print("Dano em Toucher")
	life-=damageALL
	$ProgressBar.value = life
	if life<=0:
		queue_free()

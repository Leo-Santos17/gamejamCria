extends Area2D

@onready var pointShot = $Centro/Gun/ShotingPoint
@onready var player = get_node("/root/Game/Player")

var bullets = 6
var localSpeed = 3000
var localRange = 700

func shoot() -> void:
	bullets-=1
	const BULLET = preload("res://Bullet.tscn")
	var newBULLET = BULLET.instantiate()
	# Alterar atributos
	newBULLET.speed = localSpeed
	newBULLET.range = localRange
	# Captura de posição e tiro
	newBULLET.global_position = pointShot.global_position
	newBULLET.global_rotation = pointShot.global_rotation
	pointShot.add_child(newBULLET)
		

func _physics_process(delta: float) -> void:
	# Pega Posição de rotação da arma e do cursor
	var player = player.global_position
	var arma = get_global_transform().get_rotation()
	
	# A captura da posição da arma é pra a arma rotacionar corretamente
	if arma>1.5 or arma<-1.5:
		scale.y = -1
	else:
		scale.y = 1
		
	# Fica mirando pro player
	look_at(player)
	


func _on_timer_timeout() -> void:
	var distance = global_position.distance_to(player.global_position)
	if distance < 600:
		if bullets > 3:
			shoot()
		elif bullets > 0:
			shoot()
		else:
			bullets = 6

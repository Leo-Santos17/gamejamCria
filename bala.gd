extends Area2D

@onready var pointShot = $Centro/Gun/ShotingPoint
@onready var player = get_node("/root/Game/Player")
var bullets = 6

func shoot() -> void:
		#bullets-=1
		if bullets>3:
			#const BULLET = preload("res://Bullet.tscn")
			#var newBULLET = BULLET.instantiate()
			#newBULLET.global_position = pointShot.global_position
			#newBULLET.global_rotation = pointShot.global_rotation
			#pointShot.add_child(newBULLET)
			print("Pow Monstro")
		elif bullets>0:
			print("Balas do monstro Acabando")
		else:
			print("Balas do monstro Recarregando")
			bullets = 6
	

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
	
	
	# Usar o Botão esquerdo do mouse para atirar (Não adianta pressionar, precisa clicar
	#if Input.is_action_just_pressed("shoot"):
	#	shoot()
		


func _on_timer_timeout() -> void:
	shoot()

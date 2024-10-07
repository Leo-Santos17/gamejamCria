extends Area2D

@onready var pointShot = $Centro/SpriteGun/ShotingPoint
var bullets = 6
const bullets_MAX = 6
var stockBullets = 64

func shoot() -> void:
	bullets-=1
	const BULLET = preload("res://Bullet.tscn")
	var newBULLET = BULLET.instantiate()
	newBULLET.global_position = pointShot.global_position
	newBULLET.global_rotation = pointShot.global_rotation
	pointShot.add_child(newBULLET)

func _physics_process(delta: float) -> void:
	# Pega Posição de rotação da arma e do cursor
	var cursor = get_global_mouse_position()
	var arma = get_global_transform().get_rotation()
	
	# A captura da posição da arma é pra a arma rotacionar corretamente
	if arma>1.5 or arma<-1.5:
		scale.y = -1
	else:
		scale.y = 1
		
	# Fica mirando pro cursor
	look_at(cursor)
	
	# Usar o Botão esquerdo do mouse para atirar (Não adianta pressionar, precisa clicar
	if Input.is_action_just_pressed("shoot"):
		leftMouse()
		
	if Input.is_action_just_pressed("reload"):
		reload()
	
	
func leftMouse():
	if bullets > 3:
		#print("Pow") # Mostrar na tela
		shoot()
	elif bullets > 0:
		#print("Balas acabando, por favor, recarregue") # Mostrar na tela
		shoot()
		#print("Recarreguar") # Mostrar na tela

func reload():
	stockBullets = stockBullets-(bullets-bullets_MAX)*-1
	bullets = bullets_MAX
	
	print(bullets)
	print(stockBullets)
	

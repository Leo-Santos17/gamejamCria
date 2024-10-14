extends Area2D

# Variáveis de cena
@onready var pointShot = $Centro/SpriteGun/ShotingPoint
@onready var player = get_node("/root/Game/Player")
@onready var Game = get_node("/root/Game")

# Variáveis Locais
var arma
var bullets = 6
const bullets_MAX : int = 20
var stockBullets : int = 200
var speedBullet : float = 400
var speedPlayer : float

# Operantes
func _ready() -> void:
	player.HUD(stockBullets, bullets)

func _physics_process(delta: float) -> void:
	if !Game.paused:
		checkBinds()
		mirar()


func mirar():
	# Mouse
	var cursor = get_global_mouse_position()
	look_at(cursor)
	# A captura da posição da arma é pra a arma rotacionar corretamente
	arma = get_global_transform().get_rotation()
	if arma>1.5 or arma<-1.5:
		scale.y = -1
	else:
		scale.y = 1

func checkBinds():
	if Input.is_action_just_pressed("shoot"):
		checkShoot()
		
	if Input.is_action_just_pressed("reload"):
		reload()

func checkShoot():
	if Game.paused == false:
		if bullets > 3:
			#print("Pow") # Mostrar na tela
			shoot()
		elif bullets > 0:
			#print("Balas acabando, por favor, recarregue") # Mostrar na tela
			shoot()
		else:
			print("Recarregue, Aperte 'R'") # Mostrar na tela

func shoot() -> void:
	bullets-=1
	const BULLET = preload("res://Bullet.tscn")
	speedPlayer = player.speedMove
	var newBULLET = BULLET.instantiate()
	
	# Speed
	newBULLET.speed = speedPlayer+speedBullet
	
	# Position and show
	newBULLET.global_position = pointShot.global_position
	newBULLET.global_rotation = pointShot.global_rotation
	pointShot.add_child(newBULLET)
	player.HUD(stockBullets, bullets)

func reload():
	if stockBullets > 0:
		stockBullets = stockBullets-(bullets-bullets_MAX)*-1
		bullets = bullets_MAX
		player.HUD(stockBullets, bullets)

func addBullets(x):
	stockBullets += x
	player.HUD(stockBullets, bullets)

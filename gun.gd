extends Area2D

# Variáveis de cena
@onready var pointShot = $Centro/SpriteGun/ShotingPoint
@onready var player = get_node("/root/Game/Player")
@onready var reloaaa = get_node("/root/Game/Player/WarnReload")
@onready var Game = get_node("/root/Game")
@onready var animation = get_node("/root/Game/Player/anim")

# Variáveis Locais
var arma
var bullets = 3
const bullets_MAX : int = 20
var stockBullets : int = 21
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
		animation.scale.x = animation.get_transform().get_scale().x * -1
		scale.y = -1
	else:
		animation.scale.x = animation.get_transform().get_scale().x * 1
		scale.y = 1

func checkBinds():
	if Input.is_action_just_pressed("shoot"):
		checkShoot()
		
	if Input.is_action_just_pressed("reload"):
		reload()

func checkShoot():
	if Game.paused == false:
		if bullets > 3:
			shoot()
		elif bullets > 0:
			# Aviso de balas acabando
			shoot()
		else:
			reloaaa.visible = true # Mostrar na tela E após pressionar, recarregar lentamente (0,5s)

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
	$Tiro.play()
	player.HUD(stockBullets, bullets)

func reload():
	if stockBullets > bullets_MAX:
		stockBullets = stockBullets-(bullets-bullets_MAX)*-1
		bullets = bullets_MAX
		player.HUD(stockBullets, bullets)
		reloaaa.visible = false
		$Reload.play()
	elif stockBullets <= 0:
		reloaaa.visible = true
	elif stockBullets < bullets_MAX:
		bullets += stockBullets
		stockBullets = 0
		player.HUD(stockBullets, bullets)
		reloaaa.visible = false
		$Reload.play()

func addBullets(x):
	stockBullets += x
	player.HUD(stockBullets, bullets)

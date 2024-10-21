extends CharacterBody2D

# Variáveis de Cena
@onready var scene = get_node("/root/Game/")
@onready var animation := $anim as AnimatedSprite2D

# Variáveis Locais
var pontuacao : int
var is_ready = true
var rateDamage = 1
var hudAmmo : String
var time : float = 400
var psicoce = 5
var is_final = false


var DA = 0
var MS = 0

var runPlayer = true

var vampMode = false
var vamp = false
var deadV = false

# Var Abilites
var life : float = 10
var lifeMax = life
var speedMove : float = 600
var speedShoot = 2500
var range = 600
var damageMulti = 1

#Var Empths
var speedMoveF : float
var speedShootF : float
var damageMultiF : float


# Operations
func _ready() :
	upStatus()
	speedMoveF = speedMove
	speedShootF = speedShoot
	damageMultiF = damageMulti

func _physics_process(delta):
	if !deadV:
		move()
		checkHurt()
		updateHUD()

# Move
func move():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.x != 0 or direction.y != 0:
		velocity = direction*speedMove
		animation.play("walk")
		move_and_slide()
	else:
		animation.play("idle")

# Dano do Toucher
func take_damage_py():
	check_fake_damage_py()
	status()
	dead()
	
func check_fake_damage_py():
	$getHurt.play()
	if (randi_range(1,psicoce) == 1):
		var overlappingMobs = $HurtBox.get_overlapping_bodies().size()
		rateDamage*overlappingMobs-1

# Dano da Bullet
func take_damage():
	check_fake_damage()
	status()
	dead()
	
func take_boss():
	$getHurt.play()
	life -= 6
	status()
	dead()

# Checks or/and Update

# Atualizar status Apenas vida
func status():
	$BarLife.hit(life)

# Atualizar status total
func upStatus():
	$BarLife.upgradeLife(life)

# Cooldown Hurt
func checkHurt():
	var overlappingMobs = $HurtBox.get_overlapping_bodies()
	if overlappingMobs.size() > 1:
		if is_ready:
			is_ready = false
			$CooldownHurt.start()
			take_damage_py()

# Update HUD bullets
func HUD(BM):
	hudAmmo = str(BM)
	%quantAmmo.text = hudAmmo
	%psicoce.text = str(psicoce)
	%psicoce/Teste.value = psicoce
	%MetaScore.text = str(pontuacao)
func updateHUD():
	%psicoce.text = str(psicoce)
	%psicoce/Teste.value = psicoce
	%MetaScore.text = str(pontuacao)

# Checks Death
func dead():
	if life <= 0 and is_final:
		get_tree().change_scene_to_file("res://GameScene_dist.tscn")
	elif life <= 0:
		deadV = true
		$Death.play()
		scene.gameOver()

var qtdReal: int
var qtdFake: int
func check_fake_damage():
	$getHurt.play()
	if (randi_range(0,psicoce) == randi_range(0,psicoce)):
		life -= rateDamage
		qtdReal += 1
	else:
		qtdFake += 1


var validScore = false
func score(x):
	pontuacao += x
	if(pontuacao > 10000):
		if !validScore:
			$SelectPower.visible = true
			$SelectPower/Timer.start()
			validScore = true
	pass

# Timers
func _on_timer_timeout() -> void:
	is_ready = true

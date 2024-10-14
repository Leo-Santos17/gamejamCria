extends CharacterBody2D

# Variáveis de Cena
@onready var scene = get_node("/root/Game/")

# Variáveis Locais
var is_ready = true
var rateDamage = 1
var hudAmmo : String
var time : float = 0
var psicoce = 1
var qtdFake: int
var qtdReal: int

# Var Abilites
var life = 10
var lifeMax = life
var speedMove = 600
var speedShoot = 600*2
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
	move()
	checkHurt()

# Move
func move():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction*speedMove
	move_and_slide()

# Dano do Toucher
func take_damage_py():
	var overlappingMobs = $HurtBox.get_overlapping_bodies().size()
	life -= rateDamage*overlappingMobs-1
	status()
	dead()

# Dano da Bullet
func take_damage():
	check_fake_damage()
	status()
	dead()


# Recuperar sem aumentar vida (Futuro)
func recLife(x):
	life = lifeMax
	#status()

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
func HUD(BM, B):
	hudAmmo = str(BM)+"/"+str(B)
	%quantAmmo.text = hudAmmo

# Checks Death
func dead():
	if life <= 0:
		scene.gameOver()

func check_fake_damage():
	if (randi_range(0,psicoce) == randi_range(0,psicoce)):
		life -= rateDamage
		qtdReal += 1
	else:
		qtdFake += 1

# Timers
func _on_timer_timeout() -> void:
	is_ready = true

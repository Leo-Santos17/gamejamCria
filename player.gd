extends CharacterBody2D

# Variáveis de Cena
@onready var scene = get_node("/root/Game/")

# Variáveis Locais
var life = 10
var lifeMax = life
var is_ready = true
var is_effected = false
var rateDamage = 0
var hudAmmo : String
var timeSM : float = 0
var timeSB : float = 0
var timeDB : float = 0
var time : float = 0
var psicoce = 4
var qtdFake: int
var qtdReal: int

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



# Actios
# Move
func move():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction*speedMove
	move_and_slide()

# Dano do Toucher
func take_damage_py():
	#print("Dano vem de Perto")
	var overlappingMobs = $HurtBox.get_overlapping_bodies().size()
	life -= rateDamage*overlappingMobs-1
	status()
	dead()

# Dano da Bullet
func take_damage():
	#print("Dano vem Longe")
	check_fake_damage()
	status()
	dead()

# Power-Ups
func powerSpeed(x):
	timeSM = 0
	speedMove *= x
	$CooldownPowerSpeed.start()
func powerSpeedShot(x):
	timeSB = 0
	speedShoot *= x
	$CooldownPowerSpeedBullet.start()
func powerDamage(x):
	timeDB = 0
	damageMulti += x
	$CooldownPowerDamage.start()
func addLife(x):
	lifeMax += x
	life = lifeMax
	upStatus()
# Recuperar sem aumentar vida (Futuro)
func recLife(x):
	life += x
	status()



# Checks or/and Update

# Atualizar status Apenas vida
func status():
	$StatusLife.value = life

# Atualizar status total
func upStatus():
	$StatusLife.max_value = lifeMax
	$StatusLife.value = life

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
		#print("Dano Real")
		qtdReal += 1
	else:
		#print("Dano Fake")
		qtdFake += 1
	print("Real: ",qtdReal," | Fake: ",qtdFake)


# Timers
func _on_timer_timeout() -> void:
	is_ready = true

func _on_cooldown_power_speed_timeout() -> void:
	timeSM += $CooldownPowerSpeed.wait_time
	is_effected = true
	if timeSM >= 5:
		$CooldownPowerSpeed.stop()
		print("Parou")
		timeSM = 0
		speedMove = speedMoveF


func _on_cooldown_power_damage_timeout() -> void:
	timeDB += $CooldownPowerDamage.wait_time
	is_effected = true
	if timeDB >= 5:
		$CooldownPowerDamage.stop()
		print("Parou")
		timeDB = 0
		damageMulti = damageMultiF


func _on_cooldown_power_speed_bullet_timeout() -> void:
	timeSB += $CooldownPowerSpeedBullet.wait_time
	is_effected = true
	if timeSB >= 5:
		$CooldownPowerSpeedBullet.stop()
		print("Parou")
		timeSB = 0
		speedShoot = speedShootF

extends CharacterBody2D

@onready var scene = get_node("/root/Game/")

var life = 10
var lifeMax = life
var is_ready = true
var rateDamage = 1
var hudAmmo : String

var speedMove = 600
var speedShoot = 600*2
var range = 600
var damageMulti = 1

func _ready() :
	upStatus()

func _physics_process(delta):
	move()
	checkHurt()

# Cooldown Hurt
func checkHurt():
	var overlappingMobs = $HurtBox.get_overlapping_bodies()
	if overlappingMobs.size() > 1:
		if is_ready:
			is_ready = false
			$CooldownHurt.start()
			take_damage_py()

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
	if life<=0:
		scene.gameOver()

# Dano da Bullet
func take_damage():
	#print("Dano vem Longe")
	life -= rateDamage
	$StatusLife.value = life
	status()
	if life<=0:
		scene.gameOver()

# Power-Ups
func powerSpeed(x):
	speedMove *= x
func powerSpeedShot(x):
	speedShoot *= x
func powerDamage(x):
	damageMulti *= x
func addLife(x):
	lifeMax += x
	life = lifeMax
	upStatus()

# Atualizar status
func status():
	$StatusLife.value = life

# All Stats
func upStatus():
	$StatusLife.max_value = lifeMax
	$StatusLife.value = life

# Recuperar sem aumentar vida
func recLife(x):
	life += x
	status()

func _on_timer_timeout() -> void:
	is_ready = true

func HUD(BM, B):
	hudAmmo = str(BM)+"/"+str(B)
	%quantAmmo.text = hudAmmo


func _on_cooldown_power() -> void:
	is_ready = true

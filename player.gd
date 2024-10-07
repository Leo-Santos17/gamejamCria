extends CharacterBody2D

var life = 10
var lifeMax = life
var is_ready = true
var rateDamage = 1

var speedMove = 600
var speedShoot = 300
var damageMulti = 1

func _ready() :
	upStatus()

func _physics_process(delta):
	move()
	var overlappingMobs = $HurtBox.get_overlapping_bodies()
	if overlappingMobs.size() > 1:
		if is_ready:
			is_ready = false
			$Cooldown.start()
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
		print("Morreu")

# Dano da Bullet
func take_damage():
	#print("Dano vem Longe")
	life -= rateDamage
	$StatusLife.value = life
	status()
	if life<=0:
		print("Morreu")

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

func status():
	$StatusLife.value = life


func upStatus():
	$StatusLife.max_value = lifeMax
	$StatusLife.value = life

# Recuperar sem aumentar vida
func recLife(x):
	life += x
	status()

func _on_timer_timeout() -> void:
	is_ready = true

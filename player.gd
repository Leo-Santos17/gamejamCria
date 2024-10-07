extends CharacterBody2D

var life = 10
var speed = 600
var rateDamage = 1

func _ready() :
	status()

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction*speed
	move_and_slide()
	var overlappingMobs = $HurtBox.get_overlapping_bodies()
	if overlappingMobs.size() > 1:
		take_damage_py()
	

func status():
	$ProgressBar.value = life
	$ProgressBar.max_value = life

func take_damage_py():
	#print("Dano vem de Player")
	var overlappingMobs = $HurtBox.get_overlapping_bodies().size()
	life -= rateDamage
	$ProgressBar.value = life
func take_damage():
	life -= rateDamage
	$ProgressBar.value = life
	if life<=0:
		queue_free()

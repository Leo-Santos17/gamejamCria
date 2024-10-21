extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var game = get_node("/root/Game/")
@onready var animation := $anim as AnimatedSprite2D

var speed = 0
var life = 500
const limitDistance = 100
var hurtDamage = 3
var dano
var critic = false
var move = false # Alterar em player para que a partir do momento que o player tomar dano, ele chame uma função $Timer.start()

func _ready() -> void:
	$BarLife.upgradeLife(life)
	$AudioStreamPlayer.play()

func _physics_process(delta: float) -> void:
	moveMob()

func moveMob():
	if player.runPlayer:
		animation.play("Walk")
		speed = player.speedMove
		var direction = global_position.direction_to(player.global_position)
		var distance = global_position.distance_to(player.global_position)
		rot(direction.x)
		velocity = direction*speed
		move_and_slide()

func rot(x):
	if x < 0:
		animation.scale.x = animation.get_transform().get_scale().x * 1
	if x > 0:
		animation.scale.x = animation.get_transform().get_scale().x * -1

func take_damage():
	#print("Dano em Toucher")
	$Hurt.play()
	CheckDamageCritic()
	spawn()
	player.runPlayer = false
	animation.play("Idle")
	$Timer.start()
	status()
	gen($Damage.global_position)

func status():
	$BarLife.hit(life)

func CheckDamageCritic():
	match randi_range(1,10):
		3:
			dano = hurtDamage*player.damageMulti
			life-=dano
			critic = true
		_:
			var ale = randi_range(1, hurtDamage-1)
			dano = ale*player.damageMulti
			life-=dano
			critic = false

func gen(dis):
	var life = preload("res://text_life.tscn")
	var newLife = life.instantiate()
	get_parent().add_child(newLife)
	newLife.is_show(dis, dano, critic)

func vampMode():
	if player.vampMode:
		if randi_range(0,1) > randi_range(0,1):
			player.life += 1

func _on_giveDamage_timeout() -> void:
	player.runPlayer = true
	$Timer.stop()
	
func spawn():
	var newMobToucher = preload("res://toucher.tscn").instantiate()
	newMobToucher.global_position = $Spawnn.global_position
	add_child(newMobToucher)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_boss"):
		body.take_boss()

extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var animation := $anim as AnimatedSprite2D

const speed = 300
var life = 10
const limitDistance = 100
var hurtDamage = 3
var dano

func _ready() -> void:
	$BarLife.upgradeLife(life)

func _physics_process(delta: float) -> void:
	moveMob()

func moveMob():
	var direction = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	rot(direction.x)
	velocity = direction*speed
	checkDistance(distance)

func checkDistance(distance):
	if distance > limitDistance:
		animation.play("Walk")
		move_and_slide()

func rot(x):
	if x < 0:
		animation.scale.x = animation.get_transform().get_scale().x * -1
	if x > 0:
		animation.scale.x = animation.get_transform().get_scale().x * 1

func take_damage():
	#print("Dano em Toucher")
	$Hurt.play()
	CheckDamageCritic()
	status()
	gen($Damage.global_position)
	if life<=0:
		player.score(100)
		audio_death()
		var n = randi_range(1, 20)
		match n:
			1: 
				var powerUpSm = preload("res://power_up_sm.tscn")
				var newPower = powerUpSm.instantiate()
				# Captura a posição desejada antes de adicionar o novo objeto
				var locatexMob = global_position
				# Configura a posição da instância
				newPower.global_position = locatexMob
				# Adiciona o objeto à cena para ser exibido
				get_parent().add_child(newPower)
			5: 
				var powerUpDs = preload("res://power_up_ds.tscn")
				var newPower = powerUpDs.instantiate()
				# Captura a posição desejada antes de adicionar o novo objeto
				var locatexMob = global_position
				# Configura a posição da instância
				newPower.global_position = locatexMob
				# Adiciona o objeto à cena para ser exibido
				get_parent().add_child(newPower)
			12:
				var powerUpDa = preload("res://power_up_da.tscn")
				var newPower = powerUpDa.instantiate()
				# Captura a posição desejada antes de adicionar o novo objeto
				var locatexMob = global_position
				# Configura a posição da instância
				newPower.global_position = locatexMob
				# Adiciona o objeto à cena para ser exibido
				get_parent().add_child(newPower)
			14:
				var powerUpHealth = preload("res://power_up_Health.tscn")
				var newPower = powerUpHealth.instantiate()
				# Captura a posição desejada antes de adicionar o novo objeto
				var locatexMob = global_position
				# Configura a posição da instância
				newPower.global_position = locatexMob
				# Adiciona o objeto à cena para ser exibido
				get_parent().add_child(newPower)
		# Eliminar enemy
		queue_free()

@onready var death = preload("res://Arts/sounds_effects/DeadMonster.mp3")
func audio_death():
	var sound_player = AudioStreamPlayer2D.new()
	sound_player.stream = death
	sound_player.global_position = global_position  # Para tocar na mesma posição do monstro
	get_parent().add_child(sound_player)
	sound_player.play()

func status():
	$BarLife.hit(life)

func CheckDamageCritic():
	match randi_range(1,10):
		3:
			dano = hurtDamage*player.damageMulti
			life-=dano
			print("Crítico!")
		_:
			var ale = randi_range(1, hurtDamage-1)
			dano = ale*player.damageMulti
			life-=dano

func gen(dis):
	var life = preload("res://text_life.tscn")
	var newLife = life.instantiate()
	get_parent().add_child(newLife)
	newLife.is_show(dis, dano)

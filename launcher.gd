extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var launcher = get_node("res://launcher.tscn")

const speed = 50
var life = 3
const limitDistance = 300
var hurtDamage = 1

func _ready() -> void:
	$StatusLife.max_value = life
	$StatusLife.value = life

func _physics_process(delta: float) -> void:
	move_mob()

func move_mob():
	var direction = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	velocity = direction*speed
	checkDistance(distance)

func checkDistance(distance):
	if distance > limitDistance:
		move_and_slide()

func take_damage():
	life-=hurtDamage*player.damageMulti
	status()
	if life<=0:
		
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
		

func status():
	$StatusLife.value = life

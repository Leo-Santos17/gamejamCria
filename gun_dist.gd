extends Area2D

# Variáveis de cena
@onready var pointShot = $Centro/SpriteGun/ShotingPoint
@onready var player = get_node("/root/Game/Player")
@onready var reloaaa = get_node("/root/Game/Player/WarnReload")
@onready var Game = get_node("/root/Game")
@onready var animation = get_node("/root/Game/Player/anim")

# Variáveis Locais
var arma

func _physics_process(delta: float) -> void:
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

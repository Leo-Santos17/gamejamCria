extends CharacterBody2D

# Variáveis de Cena
@onready var scene = get_node("/root/Game/")
@onready var animation := $anim as AnimatedSprite2D

# Var Abilites
var speedMove : float = 600

func _physics_process(delta):
	move()

# Move
func move():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.x != 0 or direction.y != 0:
		velocity = direction*speedMove
		animation.play("walk")
		move_and_slide()
	else:
		animation.play("idle")
		

func exit():
	print("Obrigado por jogar")


func _on_hurt_box_body_entered(body: Node2D) -> void:
	print("PINTO")

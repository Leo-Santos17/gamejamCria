extends Area2D

@onready var player = get_node("/root/Game/Player")
var time : float
var rate = 1

func _on_body_entered(body: Node2D) -> void:
	print(player.life)
	player.life += rate
	print(player.life)
	player.status()
	queue_free()

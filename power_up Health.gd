extends Area2D

@onready var player = get_node("/root/Game/Player")

func _on_body_entered(body: Node2D) -> void:
	print("Entrou")
	player.addLife(1)
	queue_free()

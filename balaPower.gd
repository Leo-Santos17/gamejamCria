extends Area2D

@onready var gun = get_node("/root/Game/Player/Gun")

func _on_body_entered(body: Node2D) -> void:
	gun.addBullets(randi_range(20, 30));
	queue_free()

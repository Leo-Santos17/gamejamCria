extends Area2D

@onready var player = get_node("/root/Game/Player")
var time : float
var rate = 1.5

func _on_body_entered(body: Node2D) -> void:
	time = 0
	player.speedMove *= rate
	$CollisionShape2D.queue_free()
	$Timer.start()
	visible = false

func _on_timer_timeout() -> void:
	time += $Timer.wait_time
	if time >= 5:
		$Timer.stop()
		time = 0
		player.speedMove = player.speedMoveF
		queue_free()

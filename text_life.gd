extends Label

var tempo = 0

func _ready() -> void:
	$Timer.start()

func is_show(pos, damage):
	text = str(damage)
	global_position = pos

func _on_timer_timeout() -> void:
	if tempo >= 1:
		$Timer.stop()
		tempo = 0
		queue_free()
	tempo+=$Timer.wait_time

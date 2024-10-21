extends Control

func write(texto):
	$Label.text = str(texto)
	visible = true
	$CoolDown.start()

func _on_cool_down_timeout() -> void:
	visible = false
	$CoolDown.stop()

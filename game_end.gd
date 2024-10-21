extends Control
var tempo = 0

func _ready() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	tempo += 1
	match tempo:
		1:
			$ColorRect/Apre.visible = true
		4:
			%police.play()
			$ColorRect/P1.visible = true
			$ColorRect/Apre.visible = false
		22:
			%noiseRadio.play()
			$ColorRect/P2.visible = true
			$ColorRect/P1.visible = false
		38:
			$ColorRect/P3.visible = true
			$ColorRect/P2.visible = false
		49:
			$ColorRect/P4.visible = true
			$ColorRect/P3.visible = false
		64:
			$ColorRect/Fim.visible = true
			$ColorRect/P4.visible = false
		66:
			$ColorRect/Fim.visible = false
		69:
			$Timer.stop()
			get_tree().change_scene_to_file("res://credits.tscn")

extends Control

var lifeInterface : float

func upgradeLife(life):
	$Ghost.value = life
	$Ghost.max_value = life
	$Vida.value = life
	$Vida.max_value = life

func hit(life):
	lifeInterface = life
	$Vida.value = life
	$Cooldown.start()


func _on_cooldown_timeout() -> void:
	$Ghost.value = lifeInterface
	$Cooldown.stop()

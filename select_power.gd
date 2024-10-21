extends Control

@onready var player = get_node("/root/Game/Player")

var readyFinal = false

func _on_forca_pressed() -> void:
	if readyFinal:
		player.damageMulti = 3
		player.damageMultiF = 3
		visible = false
		Engine.time_scale = 1
		#Continuar musica

func _on_vamp_eter_pressed() -> void:
	if readyFinal:
		player.vampMode = true
		visible = false
		Engine.time_scale = 1
		#Continuar musica


func _on_timer_timeout() -> void:
	# Pausar Música Ou usar outro de aguardo
	readyFinal = true
	$Timer.stop()
	Engine.time_scale = 0

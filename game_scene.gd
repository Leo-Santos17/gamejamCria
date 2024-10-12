extends Node2D

@onready var pause_menu = $Player/PauseMenu
@onready var game_over = $Player/GameOver
var paused = false

var tempo : int = 0
var mess = str(tempo)
#var spawnLAUNCHERmax = 10
#var spawnTOUCHERmax = 10
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Paused"):
		pauseMenu()

func spawn_mobs():
	var newMobToucher = preload("res://toucher.tscn").instantiate()
	var newMobLauncher = preload("res://launcher.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	
	match randi_range(0,10):
		1:
			newMobToucher.global_position = %PathFollow2D.global_position
			add_child(newMobToucher)
			
	match randi_range(0,10):
		1:
			newMobLauncher.global_position = %PathFollow2D.global_position
			add_child(newMobLauncher)

func _on_temporizar_timeout() -> void:
	tempo += 1
	mess = str(tempo)
	%Temporizador.text = mess
	check_stop()
	

func check_stop():
	if tempo >= 240:
		$Temporizar.stop()
		print("Parou")

func difficult_time():
	if tempo<30:
		print("30 segundos")
	elif tempo<75:
		print("Teste")
	elif tempo<110:
		print("110 Segundos")
	elif tempo<170:
		print("170 segundos")

func _on_timer_spawm_mobs() -> void:
	spawn_mobs()

func gameOver():
	game_over.show()
	Engine.time_scale = 0

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused

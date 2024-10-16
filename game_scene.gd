extends Node2D

@onready var pause_menu = $Player/PauseMenu
@onready var game_over = $Player/GameOver

# Variáveis
var paused = false

var tempo : int = 0
var mess = str(tempo)
var spawnLAUNCHERmax = 10
var spawnTOUCHERmax = 10


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Paused"):
		pauseMenu()


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
		spawnTOUCHERmax = 5
		spawn_mob_toucher()
	elif tempo<75:
		spawnTOUCHERmax = 3
		spawnLAUNCHERmax = 5
		spawn_mob_launcher()
		spawn_mob_toucher()
	elif tempo<110:
		spawnTOUCHERmax = 4
		spawnLAUNCHERmax = 4
		spawn_mob_launcher()
		spawn_mob_toucher()
	elif tempo<170:
		spawnLAUNCHERmax = 1
		spawnTOUCHERmax = 1

func _on_timer_spawm_mobs() -> void:
	difficult_time()
	pass

func gameOver():
	game_over.show()
	paused = true
	Engine.time_scale = 0

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
		$Back.stream_paused = false
	else:
		pause_menu.show()
		Engine.time_scale = 0
		$Back.stream_paused = true
	
	paused = !paused


# Spawns
func spawn_mob_toucher():
	var newMobToucher = preload("res://toucher.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	
	match randi_range(1,spawnTOUCHERmax):
		1:
			newMobToucher.global_position = %PathFollow2D.global_position
			add_child(newMobToucher)
			

func spawn_mob_launcher():
	var spawnLAUNCHERmax = 10
	var newMobLauncher = preload("res://launcher.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	
	match randi_range(1,spawnLAUNCHERmax):
		1:
			newMobLauncher.global_position = %PathFollow2D.global_position
			add_child(newMobLauncher)

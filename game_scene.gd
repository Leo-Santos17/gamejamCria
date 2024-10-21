extends Node2D

@onready var pause_menu = $Player/PauseMenu
@onready var game_over = $Player/GameOver
@onready var Player = $Player


# Variáveis
var paused = false

var tempo : int = 180
var mess = str(tempo)
var minute : int
var second
var spawnLAUNCHERmax = 10
var spawnTOUCHERmax = 10
var unspawn = false

func _ready() -> void:
	Engine.time_scale = 1
	print("Teste")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Paused"):
		pauseMenu()

func _on_temporizar_timeout() -> void:
	tempo -= 1
	if tempo <= 60:
		mess = str(tempo)
		%Temporizador.text = mess
	else:
		second = tempo%60
		if second < 10:
			second = str("0",second)
		minute = tempo/60
		mess = str(minute,":",second)
		%Temporizador.text = mess
	check_stop()
	

func check_stop():
	if tempo <= 0:
		$Temporizar.stop()
		print("Parou")

func difficult_time():
	if tempo>170:
		spawnTOUCHERmax = 5
		spawn_mob_toucher()
	elif tempo>110:
		spawnTOUCHERmax = 3
		spawnLAUNCHERmax = 5
		spawn_mob_launcher()
		spawn_mob_toucher()
		Player.psicoce = 4
	elif tempo>75:
		spawnTOUCHERmax = 4
		spawnLAUNCHERmax = 4
		spawn_mob_launcher()
		spawn_mob_toucher()
		
		Player.psicoce = 3
	elif tempo>30:
		spawnLAUNCHERmax = 1
		spawnTOUCHERmax = 1
		spawn_mob_launcher()
		spawn_mob_toucher()
		Player.psicoce = 2
	elif tempo > 0:
		match tempo:
			29:
				$Player/warnings.write("Que estranho")
			25:
				$Player/warnings.write("Por que estou sentindo dor?")
			20:
				$Player/warnings.write("Será que estou alucinando?")
			16:
				$Player/warnings.write("O meu passado não sai")
			12:
				$Player/warnings.write("Que pressão é essa?")
			8:
				$Player/warnings.write("Me sinto sufocado?")
			4:
				$Player/warnings.write("Isso é familiar...")
		Player.psicoce = 1
	elif tempo == 0:
		if !unspawn:
			audio_death()
			Player.psicoce = 1
			$spaww.queue_free()
			var newMobLauncher = preload("res://boss.tscn").instantiate()
			newMobLauncher.global_position = $Spawn.global_position
			add_child(newMobLauncher)
			unspawn = true
			Player.is_final = true
			$Player/warnings.write("Há merda, de novo não")

func _on_timer_spawm_mobs() -> void:
	difficult_time()

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
		$Player/PauseMenu/Controls.visible = false
		$Player/PauseMenu/MarginContainer.visible = true
		pause_menu.show()
		Engine.time_scale = 0
		$Back.stream_paused = true
	
	paused = !paused

@onready var death = preload("res://Arts/sounds_effects/dead.mp3")
func audio_death():
	var sound_player = AudioStreamPlayer2D.new()
	sound_player.stream = death
	sound_player.global_position = global_position  # Para tocar na mesma posição do monstro
	get_parent().add_child(sound_player)
	sound_player.play()


# Spawns
func spawn_mob_toucher():
	var newMobToucher = preload("res://toucher.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	
	match randi_range(1,spawnTOUCHERmax):
		1:
			newMobToucher.global_position = %PathFollow2D.global_position
			$spaww.add_child(newMobToucher)

func spawn_mob_launcher():
	var spawnLAUNCHERmax = 10
	var newMobLauncher = preload("res://launcher.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	
	match randi_range(1,spawnLAUNCHERmax):
		1:
			newMobLauncher.global_position = %PathFollow2D.global_position
			$spaww.add_child(newMobLauncher)

extends Node2D

@onready var pause_menu = $Player/PauseMenu
@onready var game_over = $Player/GameOver
@onready var Player = $Player
var tempo : int


func _ready() -> void:
	Engine.time_scale = 1
	$Tempo.start()
	
func _on_tempo_timeout() -> void:
	tempo += 1
	match tempo:
		5:
			$Player/warnings.write("O que... eu fiz?")
		9:
			$Player/warnings.write("Não... isso não pode ser real...")
		14:
			$Player/warnings.write("Eles era monstros... ou não?")
		17:
			$Player/warnings.write("Eles eram monstros... ou não?")
		20:
			$Player/warnings.write("Por que ninguém conseguiu me impedir?")
		23:
			$Player/warnings.write("Isso é culpa minha...")
		27:
			$Player/warnings.write("Mas não faz sentido...")
		31:
			$Player/warnings.write("Os grunidos... não eram de monstros?")
		35:
			$Player/warnings.write("Por que eu acreditei nessas vozes?")
		39:
			$Player/warnings.write("Eu não posso voltar atrás...")
		43:
			$Player/warnings.write("Por quê?")
		47:
			$Player/warnings.write("Apenas comigo")
		51:
			$Player/warnings.write("Será que possuo salvação?")
		55:
			$Player/warnings.write("Até quando essa droga persistirá...")
		59:
			$Player/warnings.write("Até quando ela estará em mim...")
		63:
			$Player/warnings.write("Já sei... Tenho uma solução..")
		67:
			$Tempo.stop
			get_tree().change_scene_to_file("res://end.tscn")
	

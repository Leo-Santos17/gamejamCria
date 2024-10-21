extends Control

@onready var main = $"../../"

func _on_resume_pressed() -> void:
	main.pauseMenu()

func _on_quit_pressed() -> void:
	var entrar = preload("res://main_menu.tscn")
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_controls_pressed() -> void:
	#$Controls.visible = true
	$MarginContainer.visible = false
	$Controls.visible = true
	pass

func _on_back_pressed() -> void:
	$MarginContainer.visible = true
	$Controls.visible = false


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

extends Control


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://GameScene.tscn")

func _on_options_pressed() -> void:
	print("Opções") # A ser desenvolvido

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://credits.tscn")

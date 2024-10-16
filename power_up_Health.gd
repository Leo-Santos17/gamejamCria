extends Area2D

@onready var player = get_node("/root/Game/Player")
var time : float
var rate = 1

@onready var end = preload("res://Arts/sounds_effects/buble.mp3")
func effect():
	var sound_player = AudioStreamPlayer2D.new()
	sound_player.stream = end
	sound_player.global_position = global_position  # Para tocar na mesma posição do monstro
	get_parent().add_child(sound_player)
	sound_player.play()


func _on_body_entered(body: Node2D) -> void:
	effect()
	print(player.life)
	player.life += rate
	print(player.life)
	player.status()
	queue_free()

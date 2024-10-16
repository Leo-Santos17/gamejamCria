extends Area2D

@onready var player = get_node("/root/Game/Player")
var time : float
var rate = 1.5


@onready var death = preload("res://Arts/sounds_effects/DeadMonster.mp3")
func audio_death():
	var sound_player = AudioStreamPlayer2D.new()
	sound_player.stream = death
	sound_player.global_position = global_position  # Para tocar na mesma posição do monstro
	get_parent().add_child(sound_player)
	sound_player.play()

@onready var end = preload("res://Arts/sounds_effects/effect_end.mp3")
func end_effect():
	var sound_player = AudioStreamPlayer2D.new()
	sound_player.stream = end
	sound_player.global_position = global_position  # Para tocar na mesma posição do monstro
	get_parent().add_child(sound_player)
	sound_player.play()

func _on_timer_timeout() -> void:
	time += $Timer.wait_time
	if time >= 5:
		$Timer.stop()
		end_effect()
		time = 0
		player.damageMulti = player.damageMultiF
		queue_free()

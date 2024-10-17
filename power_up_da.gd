extends Area2D

@onready var player = get_node("/root/Game/Player")
@onready var HUD = get_node("/root/Game/Player/HUD_Power/Adapte/Damage")
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
	HUD.get_child(1).value = time
	if time >= 5:
		$Timer.stop()
		end_effect()
		time = 0
		player.damageMulti = player.damageMultiF
		player.DA = 0
		HUD.visible = false
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	player.DA += 1
	$effect.play()
	time = 0
	player.damageMulti *= rate
	$CollisionShape2D.queue_free()
	$Timer.start()
	HUD.visible = true
	HUD.get_child(0).text = str(player.DA,"X")
	visible = false

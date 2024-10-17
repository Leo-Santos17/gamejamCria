extends Area2D

@onready var player = get_node("/root/Game/Player")
@onready var animation = get_node("/root/Game/Player/anim")
@onready var HUD = get_node("/root/Game/Player/HUD_Power/Adapte/Speed")
var time : float
var rate = 1.5

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
		end_effect()
		$Timer.stop()
		time = 0
		player.speedMove = player.speedMoveF
		player.MS = 0
		HUD.visible = false
		queue_free()
		animation.speed_scale = 1

func _on_body_entered(body: Node2D) -> void:
	player.MS += 1
	$effect.play()
	time = 0
	player.speedMove *= rate
	$CollisionShape2D.queue_free()
	$Timer.start()
	visible = false
	HUD.visible = true
	HUD.get_child(0).text = str(player.MS,"X")
	animation.speed_scale = 3

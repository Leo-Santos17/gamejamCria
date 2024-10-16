extends Area2D

@onready var player = get_node("/root/Game/Player")
@onready var animation = get_node("/root/Game/Player/anim")
var time : float
var rate = 1.5

@onready var end = preload("res://Arts/sounds_effects/effect_end.mp3")
func end_effect():
	var sound_player = AudioStreamPlayer2D.new()
	sound_player.stream = end
	sound_player.global_position = global_position  # Para tocar na mesma posição do monstro
	get_parent().add_child(sound_player)
	sound_player.play()

func _on_body_entered(body: Node2D) -> void:
	$effect.play()
	time = 0
	player.speedMove *= rate
	$CollisionShape2D.queue_free()
	$Timer.start()
	visible = false
	animation.speed_scale = 3
func _on_timer_timeout() -> void:
	time += $Timer.wait_time
	if time >= 5:
		end_effect()
		$Timer.stop()
		time = 0
		player.speedMove = player.speedMoveF
		queue_free()
		animation.speed_scale = 1

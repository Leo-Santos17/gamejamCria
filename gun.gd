extends Area2D

var bullets = 30

func _physics_process(delta: float) -> void:
	var cursor = get_global_mouse_position()
	var arma = get_global_transform().get_rotation()
	if arma>1.5 or arma<-1.5:
		scale.y = -1
	else:
		scale.y = 1
	look_at(cursor)
	
	
	
	##bullets-=1
	##if bullets>3:
	##	# Executar Tiro
	##elif bullets>0:
	##	# Avisar na tela para recarregar e indicar que a munição está acabando, mas ter tiro
	##else:
	##	# Travar tiros e recarregar (Chamar função para verificar se há balas em estoque
	
	

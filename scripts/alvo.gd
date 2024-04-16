extends Area2D

var patoatual



func _ready():
	pass 

# FUNÇAO QUE DETECTA COLISAO DO ALVO (MIRA) COM O PATO
func _on_alvo_body_entered(body):
	patoatual = body
	pass

# FUNÇAO QUE DETECTA APERTO DE QUALQUER TECLA
func _input(event):
	# se apertar o botao atirar
	if Input.is_action_just_pressed("atirar"):
		$AudioStreamPlayer2D.play() #toca o som
		if patoatual == null:
			print("Sem patos para matar")
		else:
			patoatual.mata()
	pass

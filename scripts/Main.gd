extends Node2D

const versao = "1.1"
var patosnatela
# armazena na variavel pato o caminho da cena pato.tscn
var pato = preload("res://cenas/Pato.tscn")
var flyaway = 0 # patos que fugirar
var mortos = 0 # patos que foram mortos
var gameover = preload("res://cenas/Game_Over.tscn")
var vida = 3
var quant_min_pato = 1
var qunat_max_pato = 6

func _ready():
	# inicializa o relógio que gera o pato
	$gerapato.start()
	# mostra a versao do jogo na Label
	$HUD/verao_label.text = str(versao)
	pass

# FAZER O ALVO ACOMPANHAR O MOUSE
func _process(delta):
	# altera o texto do placar
	$HUD/Label.text = str(mortos)
	# iguala o alvo a posição X e Y, sempre que mecher o mouse o alvo acomanha
	$alvo.position.x = get_local_mouse_position().x
	$alvo.position.y = get_local_mouse_position().y
	
	# verifica se deu GAME OVER
	#print(flyaway)
	if flyaway >= vida:
			gameover()
			pass
	pass

# FUNÇAO QUE ADICIONA PATOS NA TELA
func nasc():
	# instancia um pato
	var novop = pato.instance()
	add_child(novop)
	# local onde os patos serão gerados (aleatorios entre 50 a 700 pixels)
	novop.position.x = rand_range(50, 700)
	# altura em que os patos serão gerados 700 padrão
	novop.position.y = 700
	pass

# FUNÇAO QUE GERA PATOS NA TELA
func _on_gerapato_timeout():
	# randomiza os patos entre 1 e 6 padrão (int para gerar numeros inteiros)
	patosnatela = int(rand_range(quant_min_pato,qunat_max_pato))
	# quantidade de vezes (n) que a função nasc() será chamada
	for n in patosnatela:
		nasc()
	pass

# CONFIGURA O RELOGIO DE TEMPO DE ESPERA ENTRE NOVOS PATOS
func _on_espera_timeout():
	$novoturno.play()
	# gera novos patos
	$gerapato.start()
	pass

# FUNÇAO QUE OCORRE QUANDO OS PATOS FOGEM
func _on_topo_body_entered(body):
	$flyaway.play()
	flyaway += 1
	patosnatela -= 1
	atualizaturno()
	pass

# FUNÇAO QUE OCORRE QUANDO OS PATOS MORREM
func _on_chao_body_entered(body):
	$colidiu.play()
	mortos += 1
	patosnatela -= 1
	atualizaturno()
	pass

# FUNÇAO QUE CONFIGURA AS RODADAS
func atualizaturno():
	if patosnatela == 0:
		$espera.start()
		# se fugiu um pato acaba a rodada
		if flyaway == 1:
			$cao.play("rindo")
			$cao_rindo.play()
			#flyaway = 0
			#mortos = 0
		else:
			$cao.play("captura")
			$cao_captura.play()
	pass

# GAME OVER
func gameover():
	$gerapato.stop()
	# chama a cena de game over
	#var gameovernow = gameover.instance()
	#add_child(gameovernow)
	get_tree().change_scene("res://cenas/Game_Over.tscn")
	pass

func egg():
	$egg/egg_appear.play("appear")
	pass


func _on_egg_appear_time_timeout():
	$audio_toasty.play()
	egg()
	pass


func _on_egg_appear_animation_finished(anim_name):
	$audio_toasty.stop()
	pass # Replace with function body.

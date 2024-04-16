extends KinematicBody2D

var lado = 1
var vel = Vector2()
var speed = 100
var queda = 1


func _ready():
	# relogio quack - temporizador do som do quack
	$quack.wait_time = rand_range(0.8, 2)
	#função randomize() melhora a aleatoriedade
	randomize()
	# o relogio movimento vai oscilar entre 0.4 e 2 aleatoriamente rand_range
	$movimento.wait_time = rand_range(0.4,2)
	# o relogio anima vai oscilar entre 0.6 e 1 aleatoriamente rand_range
	$anima.wait_time = rand_range(0.6, 1)
	pass


func _process(delta):
	# movimentação horizontal
	position.x += speed * lado * delta
	# movimentação vertical
	position.y -= 140 * queda * delta
	# espelhamento da animação
	if lado < 0:
		# inverte animação para esquerda
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	pass


func _on_movimento_timeout():
	# inverte o lado do pato
	lado = lado *(-1)
	pass


func _on_anima_timeout():
	# troca a animação do pato de lado e cima
	if $AnimatedSprite.animation == "cima":
		$AnimatedSprite.animation ="lado"
	elif $AnimatedSprite.animation == "lado":
		$AnimatedSprite.animation = "cima"
	pass

# FUNÇAO MATA
func mata():
	# inicia a animação de susto
	$AnimatedSprite.animation = "susto"
	# inicia a animação da morte
	$morte.start()
	pass

# FUNÇAO MORTE
func _on_morte_timeout():
	$audio_quack.stop()
	$AnimatedSprite.animation = "morte"
	queda = -1
	lado = 0 # para não se movimentar nas laterais
	pass


func _on_quack_timeout():
	$audio_quack.play()
	pass

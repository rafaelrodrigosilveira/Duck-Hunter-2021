extends CanvasLayer


func _ready():
	pass


func _on_reiniciar_pressed():
	$som_gameover.play()
	get_tree().change_scene("res://cenas/Main.tscn")
	pass 


func _on_fechar_pressed():
	get_tree().quit()
	pass

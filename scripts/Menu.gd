extends CanvasLayer

func _ready():
	pass


func _on_Jogar_pressed():
	get_tree().change_scene("res://cenas/Main.tscn")
	pass 


func _on_Sair_pressed():
	get_tree().quit()
	pass 

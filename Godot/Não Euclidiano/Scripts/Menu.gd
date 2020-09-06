extends Spatial

func _ready():
	pass 
	OS.window_fullscreen = true

func _on_Sair_pressed():
	get_tree().quit()


func _on_Jogar_pressed():
	get_tree().change_scene("res://Mapas/Mapa1.tscn")

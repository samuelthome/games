extends Node

func _ready():
	$ColorRect.visible = false 


func _process(delta):
	
	
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused == false:
			get_tree().paused = true
			
			
			#Pega a posição do player para mostrar a pause 
			#$VBoxContainer.rect_position.x  = get_parent().get_node("Player").position.x - 30
			#$VBoxContainer.rect_position.y = get_parent().get_node("Player").position.y - 60

			$ColorRect.rect_position.x  = get_parent().get_node("Player").position.x - ($ColorRect.rect_size.x / 2)
			$ColorRect.rect_position.y = get_parent().get_node("Player").position.y - ($ColorRect.rect_size.y / 2)

			
			$ColorRect.visible = true  
		else:
			despausar()


func _on_Voltar_pressed():
	despausar()


func _on_Sair_para_o_menu_pressed():
	despausar()
	get_tree().change_scene("res://Menu.tscn")

func despausar():
	get_tree().paused = false 
	$ColorRect.visible = false 

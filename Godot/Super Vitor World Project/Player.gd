extends KinematicBody2D
#Script do nosso player


const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_FORCE = -550

const MAGIA = preload("res://Magia.tscn")

var lifes = 3 
var life = 3
var motion = Vector2()

#X -> Positivo = Direita
#X -> Negativo = Esquerda
#Y -> Positivo = Baixo
#Y -> Negativo = Cima


func _physics_process(delta):
	
	motion.y += GRAVITY 
	
	#Detecta mais devagar a pressionamento 
	if Input.is_action_just_pressed("ATIRAR"):
		tiro()
	
	#Andou para direta 
	if Input.is_action_pressed("DIREITA"):
		motion.x = SPEED
		$Sprite.play("Run")
		$Sprite.flip_h = false
		
	#Andou para esquerda 
	elif Input.is_action_pressed("ESQUERDA"):
		motion.x = -SPEED
		$Sprite.play("Run")
		$Sprite.flip_h = true
	
	#Parou 
	else:
		motion.x = 0
		$Sprite.play("Idle")
		
		if Input.is_action_pressed("PULAR"):
			if is_on_floor():
				motion.y = JUMP_FORCE
				$SomJump.play()
		else:
			$SomJump.stop()
		
		$Sprite.play("Jump")
		
		
	motion = move_and_slide(motion, UP)
	
	#Se caiu no buraco 
	if ($".".position.y > 500): 
		get_tree().change_scene("res://Menu.tscn")
		
			#$ColorRect.rect_position.x  = get_parent().get_node("Player").position.x - ($ColorRect.rect_size.x / 2)
			#$ColorRect.rect_position.y = get_parent().get_node("Player").position.y - ($ColorRect.rect_size.y / 2)
					
	#mover a camera 
	get_parent().get_node("CameraGui").position.x = $".".position.x
	get_parent().get_node("CameraGui").position.y = $".".position.y
		
		


func _on_pes_body_entered(body):	
	body.dano()	
	motion.y = JUMP_FORCE

func dano():
	get_node("Anime").play("Damage")

func _on_dano_body_entered(body):
	
	#Só da o dano se sumiu a barrinha de vida 
	if (!$ProgressBarVida.visible):
		#Levou um dano 
		life -= 1 
		$ProgressBarVida.value -= 1
		$ProgressBarVida.visible = true
		$TimerVida.start()
		if life == 0:
			#diminui a vida 
			lifes -= 1
			#volta o life para 3 e arruma barrinha 
			life = 3
			$ProgressBarVida.value = 3
			#Altera a gui na tela mostrando a nova vida 
			get_parent().get_node("CameraGui/Vida").text = "Vida: " + str(lifes)
			#Se perdeu todas as vidas volta para o menu inicial 
			if lifes == 0:
				get_tree().change_scene("res://Menu.tscn")


func _on_Player_ready():
	$ProgressBarVida.visible = false

func _on_TimerVida_timeout():
	$ProgressBarVida.visible = false

func tiro():
	var bala = MAGIA.instance()
	if ($Sprite.flip_h):
		bala.esquerda()
	get_parent().add_child(bala)
	bala.position = $Position2D.global_position

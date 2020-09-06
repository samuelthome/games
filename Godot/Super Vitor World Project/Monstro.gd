extends StaticBody2D

var flip = true
var posicao_inicial
var posicao_final

export(float) var velocidade = 0.7
export(int) var distancia_andar = 100
export(int) var vida = 1 

func _ready():
	$AnimatedSprite.play("walk")
	
	posicao_inicial = $".".position.x 
	posicao_final = posicao_inicial + distancia_andar
	
	
func _process(delta):
	
	if (posicao_inicial <= posicao_final and flip): 
		$".".position.x += velocidade 
		$AnimatedSprite.flip_h = false 
		
		if ($".".position.x >= posicao_final):
			flip = false 
	
	if ($".".position.x >= posicao_inicial and !flip):
		$".".position.x -= velocidade 
		$AnimatedSprite.flip_h = true 
		
		if ($".".position.x <= posicao_inicial):
			flip = true 
		
		
func dano():
	get_node("Anime").play("Die")
	$SomMorrendo.play()
	
func die():
	$".".queue_free()
	
	
	
	

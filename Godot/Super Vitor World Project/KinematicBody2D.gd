extends KinematicBody2D

var velocidade = Vector2()
var direita = true

func _ready():
	if (direita):
		velocidade.x = 600
	else:
		velocidade.x = -600

func _physics_process(delta):
	#print(position.x)
	
	if (position.x > 3000):
		queue_free()
		print("morreu")
	elif (position.x < -3000):
		queue_free()
		print("morreu")
	
	move_and_slide(velocidade)
	
func esquerda():
	direita = false 
	

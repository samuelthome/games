extends Area2D


const SPEED = 400
var velocidade = Vector2()
var direita = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Atirou.play()


func _physics_process(delta):
	if (direita):
		velocidade.x = SPEED * delta 
	else:
		velocidade.x = (SPEED*-1) * delta 
	
	translate(velocidade)
	$AnimatedSprite.play("shoot")


func _on_VisibilityNotifier2D_screen_exited():
	print("morreu")
	queue_free()
	
func esquerda():
	direita = false 
	
func _on_Magia_body_entered(body):
	body.dano()

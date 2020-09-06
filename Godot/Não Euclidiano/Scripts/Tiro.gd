extends Spatial

const SPEED = 50
var velocidade = Vector3()
var somandoZ = false 
var somandoX = false 
var zinicial = 0
var xinicial = 0

const MARCA = preload("res://Conteudo/Marca.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$SomTiro.play()

func _physics_process(delta):
	velocidade.z = -SPEED * delta
	translate(velocidade)
		
	if zinicial == 0:
		zinicial = $".".translation.z
	elif zinicial != 0:
		if zinicial >  $".".translation.z:
			somandoZ = false
		else: 
			somandoZ = true 
			
	
	if xinicial == 0:
		xinicial = $".".translation.x
	elif xinicial != 0:
		if xinicial >  $".".translation.x:
			somandoX = false
		else: 
			somandoX = true 			
	

func _on_VisibilityNotifier_screen_exited():
	queue_free()

func _on_Tiro_body_entered(body):
	if body is RigidBody:
		pass
	else:
		var marca = MARCA.instance()
		body.add_child(marca)
		marca.global_transform = $Position3D.global_transform
		marca.scale.x = 0.2
		marca.scale.y = 0.2
		marca.scale.z = 0.2
		marca.rotation_degrees = body.rotation_degrees
		
		
	if body is RigidBody:
		var direcao1 = Vector3(0,0,100)
		var direcao2 = Vector3(0,0,-100)
		if somandoZ:
			body.apply_impulse(velocidade, direcao1)
		else:
			body.apply_impulse(velocidade, direcao2)
		
		var direcao3 = Vector3(100,0,0)
		var direcao4 = Vector3(-100,0,0)
		if somandoX:
			body.apply_impulse(velocidade, direcao3)
		else:
			body.apply_impulse(velocidade, direcao4)
		
		
	queue_free()


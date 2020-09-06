extends KinematicBody

var accel = 15 
var speed = 7
var velocity = Vector3()

var sens = 0.2
var grav = -9.6
var max_grav = -150 

const TIRO = preload("res://Conteudo/Tiro.tscn")
const MAT_TIRO = preload("res://Imagens/Materials/Tiro.tres")
const MAT_TIRO_INV = preload("res://Imagens/Materials/Invisivel.tres")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		var movimento = event.relative
		$Camera.rotation.x += deg2rad(-movimento.y * sens)
		$Camera.rotation.x = clamp($Camera.rotation.x, deg2rad(-90), deg2rad(90))
		
		rotation.y += deg2rad(-movimento.x * sens)
		
func _physics_process(delta):
	
	var target_dir = Vector2(0, 0)
	
	if Input.is_action_pressed("ui_left"):
		target_dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		target_dir.x += 1
	if Input.is_action_pressed("ui_up"):
		target_dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		target_dir.y += 1
	if Input.is_action_just_pressed("Tiro"):
		var bala = TIRO.instance()
		get_parent().add_child(bala)
		bala.transform = $Camera/Tiro.global_transform
		AnimTiro()
		
	
	target_dir = target_dir.normalized().rotated(-rotation.y)
	
	velocity.x = lerp(velocity.x, target_dir.x * speed, accel * delta)
	velocity.z = lerp(velocity.z, target_dir.y * speed, accel * delta)

	velocity.y += grav * delta
	if velocity.y < max_grav:
		velocity.y = max_grav
	
	move_and_slide(velocity, Vector3(0, 1, 0))
	
	#Se estiver chão e pular 
	if is_on_floor() and Input.is_action_pressed("Pular"):
		velocity.y = 4
		$Pulo.play()
	if is_on_floor() and velocity.y < 0:
		velocity.y = 0
	
func AnimTiro():
	$EfeitoDoTiro.start()
	$Camera/Arma.set_surface_material(5, MAT_TIRO)


func _on_EfeitoDoTiro_timeout():
	$Camera/Arma.set_surface_material(5, MAT_TIRO_INV)

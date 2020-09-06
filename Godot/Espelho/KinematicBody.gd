extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var accel = 15 
var speed = 7
var velocity = Vector3()
var sens = 0.2
var grav = -9.6
var max_grav = -150 

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		var movimento = event.relative
		$Camera.rotation.x += deg2rad(-movimento.y * sens)
		$Camera.rotation.x = clamp($Camera.rotation.x, deg2rad(-90), deg2rad(90))
		
		rotation.y += deg2rad(-movimento.x * sens)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
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
	
	target_dir = target_dir.normalized().rotated(-rotation.y)
	
	velocity.x = lerp(velocity.x, target_dir.x * speed, accel * delta)
	velocity.z = lerp(velocity.z, target_dir.y * speed, accel * delta)
	
	move_and_slide(velocity, Vector3(0, 1, 0))

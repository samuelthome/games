extends Spatial

func _ready():
	$Radioacitive.play()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("Reiniciar"):
		get_tree().reload_current_scene()

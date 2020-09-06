extends Area

var bolas = 0

func _ready():
	$Panel.hide()

func _on_Area_body_entered(body):
	if body is RigidBody:
		bolas += 1
		body.queue_free()
		if bolas == 2:
			$Panel.show()
			

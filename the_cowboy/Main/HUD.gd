extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func modificar_tiempo(new_val):
	$MarginContainer/LblTimer.text = str(new_val)

func modificar_puntos(new_val):
	$MarginContainer/LblScore.text = str(new_val)

extends Area2D
var tween: Tween;

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = create_tween();
	tween.tween_property($AnimatedSprite2D, "scale", Vector2(0.5, 0.5), 0.5)
	tween.tween_property($AnimatedSprite2D, "scale", Vector2(0.06, 0.06), 0.06)
	
	tween.tween_property($AnimatedSprite2D, "modulate:a", 0.0, 0.2)
	tween.tween_property($AnimatedSprite2D, "modulate:a", 1.0, 1.0) 
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func pickup():
	tween.play()
	call_deferred("queue_free")

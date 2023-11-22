extends Area2D

signal picked;
signal hurt;

var velocidad = Vector2.ZERO;
var speed = 350;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input();
	position += velocidad*delta;
	position.x = clamp(position.x, 0, 900);
	position.y = clamp(position.y, 0, 600);
	process_animation();
	

func get_input():
	velocidad = Vector2.ZERO;
	if(Input.is_action_pressed("ui_left")):
		velocidad.x = -1;
	if(Input.is_action_pressed("ui_right")):
		velocidad.x = 1;
	if(Input.is_action_pressed("ui_up")):
		velocidad.y = -1;
	if(Input.is_action_pressed("ui_down")):
		velocidad.y = 1;
		
	if(velocidad.length() > 0):
		velocidad = velocidad.normalized()*speed;
		
func process_animation():
	if(velocidad.length() != 0):
		$AnimatedSprite2D.play("caminar");
		if velocidad.x < 0:
			$AnimatedSprite2D.flip_h = true;
		else:
			$AnimatedSprite2D.flip_h = false;
	else:
		$AnimatedSprite2D.play("caminar");
		
func game_overPlayer():
	set_process(false);
	#AnimatedSprite2D.animation = "quieto" que hace que descanse

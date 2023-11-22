extends Node2D
const nivel_basico=5;

var level=0;
var scrensize=Vector2.ZERO;

var bullet = preload('res://bullet/area_2d.tscn');
var moneda = preload('res://bullet/moneda/moneda.tscn');

var tiemleft =0;
var score = 0;

@onready var GameOverTimer=Timer.new()

func generar_Moneda():
	for i in range(nivel_basico + level):
		var moneda1 = moneda.instantiate();
		moneda1.position = Vector2(randi_range(0,scrensize.x), randi_range(0, scrensize.y));
		$contenedor.add_child(moneda1);
		

# Called when the node enters the scene tree for the first time.
func _ready():
	$enemugo.visible = false;
	randomize()
	timer_opciones();
	
	$HUD/LblGameOver.visible = false;
	tiemleft = 3;
	$HUD.modificar_tiempo(tiemleft);
	$HUD.modificar_puntos(score);
	scrensize = get_viewport_rect().size
	
	generar_Moneda();
	generarmonedaTime();
	
func timer_opciones():
	GameOverTimer.wait_time=3
	GameOverTimer.connect("timeout", Callable(self,"_onGameOverTimer_timeout"))
	add_child(GameOverTimer)
	
func _onGameOverTimer_timeout():
		get_tree().change_scene_to_file("res://menu/menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $contenedor.get_child_count() == 0:
		level+=1
		tiemleft+=5
		generar_Moneda()

func _on_player_area_entered(area):
	if area.is_in_group("moneda"):
		_on_player_picked("moneda")
	elif area.is_in_group("bullet"):
		_on_player_picked("bullet")
	elif area.is_in_group("enemigo"):
		emit_signal("hurt")
	if area.has_method("pickup"):
		area.pickup()

func _on_player_picked(type):
	print("Hola creo que voy a entrar aqui")
	match type:
		"moneda":
			score+=1
			$HUD.modificar_puntos(score)
		"bullet":
			tiemleft+=5
			$HUD.modificar_tiempo(tiemleft)
			
func gameOver():
	$GameTimer.stop()
	$MonedaTimer.stop()
	$HUD/LblGameOver.visible=true
	$HUD/LblGameOver.text=str("GAME...OVER")
	$player.game_overPlayer()
	GameOverTimer.start()
	
func generarmonedaTime():
	var interval = randf_range(5,10);
	$MonedaTimer.wait_time=interval
	$MonedaTimer.start()

func _on_moneda_timer_timeout():
	$MonedaTimer.stop()
	var moneda1 =moneda.instantiate()
	moneda1.position.x=randf_range(25, 850)
	moneda1.position.y=randf_range(25, 550)
	$contenedor.add_child(moneda1)
	generarmonedaTime()
	
func _on_player_hurt():
	print("Entre a la selñal hurt")
	gameOver()
	
	
func _on_game_timer_timeout():
	tiemleft-=1
	$HUD.modificar_tiempo(tiemleft)
	if tiemleft<=0:
		gameOver()

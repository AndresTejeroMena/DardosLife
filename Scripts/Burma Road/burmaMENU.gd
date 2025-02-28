extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.ESCENA_ACTUAL = "BURMA_MENU"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_1_pressed():
	GLOBAL.NUMERO_JUGADORES = 1
func _on_2_pressed():
	GLOBAL.NUMERO_JUGADORES = 2
func _on_3_pressed():
	GLOBAL.NUMERO_JUGADORES = 3
func _on_4_pressed():
	GLOBAL.NUMERO_JUGADORES = 4
func _on_5_pressed():
	GLOBAL.NUMERO_JUGADORES = 5
func _on_6_pressed():
	GLOBAL.NUMERO_JUGADORES = 6
func _on_7_pressed():
	GLOBAL.NUMERO_JUGADORES = 7
func _on_8_pressed():
	GLOBAL.NUMERO_JUGADORES = 8



func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Escenas/burmaGAME.tscn")
func _on_atras_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")

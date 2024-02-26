extends Control
func _ready():
	GLOBAL.EMPEZAR_DOBLES = false
	GLOBAL.ACABAR_DOBLES = true
func _on_button_301_pressed():
	GLOBAL.MODO_PUNTOS = 301
func _on_button_401_pressed():
	GLOBAL.MODO_PUNTOS = 401
func _on_button_501_pressed():
	GLOBAL.MODO_PUNTOS = 501
func _on_button_601_pressed():
	GLOBAL.MODO_PUNTOS = 601
func _on_button_701_pressed():
	GLOBAL.MODO_PUNTOS = 701
func _on_button_802_pressed():
	GLOBAL.MODO_PUNTOS = 801
func _on_button_903_pressed():
	GLOBAL.MODO_PUNTOS = 901


func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Escenas/x_01_GAME.tscn")


func _on_atras_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")


func _on_activar_dobles_toggled(pulsado):
	if pulsado == true:
		GLOBAL.ACABAR_DOBLES = true
	else:
		GLOBAL.ACABAR_DOBLES = false
		
func _on_empezar_dobles_toggled(pulsado):
	if pulsado == true:
		GLOBAL.EMPEZAR_DOBLES = true
	else:
		GLOBAL.EMPEZAR_DOBLES = false

func _on_jugadores_1_pressed():
	GLOBAL.NUMERO_JUGADORES = 1
func _on_jugadores_2_pressed():
	GLOBAL.NUMERO_JUGADORES = 2
func _on_jugadores_3_pressed():
	GLOBAL.NUMERO_JUGADORES = 3
func _on_jugadores_4_pressed():
	GLOBAL.NUMERO_JUGADORES = 4
func _on_jugadores_5_pressed():
	GLOBAL.NUMERO_JUGADORES = 5
func _on_jugadores_6_pressed():
	GLOBAL.NUMERO_JUGADORES = 6
func _on_jugadores_7_pressed():
	GLOBAL.NUMERO_JUGADORES = 7
func _on_jugadores_8_pressed():
	GLOBAL.NUMERO_JUGADORES = 8




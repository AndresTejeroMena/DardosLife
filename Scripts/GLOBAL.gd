extends Node

# VARIABLES---------------------------------------------------------
#GENERALES
var NUMERO_JUGADORES : int = 1
var ULTIMO_DARDO = "0:S"
var PUERTO = "COM3"
var SONIDO_DARDO = "S1"

#X01
var MODO_PUNTOS : int = 301
var ACABAR_DOBLES : bool = true
var EMPEZAR_DOBLES : bool = false
#CRICKET
var objetivos_cricket = [20,19,18,17,16,15,25]
var MODO_CRICKET = "Normal"
var cutthroat : bool = true
#HUNDIR LA FLOTA
var radar : bool = true
var portaviones : int = 0
var acorazado : int = 0
var crucero : int = 0
var destructores : int = 0
var submarinos : int =0
#CONECTA 4
var objetivos_conecta4 = [0,20,19,18,17,16,15,14]
var CONECTA_ALEATORIO = false
#FUTBOL
var lista_dorsales = [10,11,12,13,14,15,16,17,18,19,20]
var escudo1 = 3
var escudo2 = 7
var camiseta1 = 0
var camiseta2 = 4
var color_local = Color(0,0,0)
var color_visitante = Color(0,0,0)
var lim_rondas = 1000
var lim_goles = 3
var lim_goles_activo = true
var lim_rondas_activo = false
#PARCHIS
var parchis_objetivo: int = 333

#CONTROL ESCENAS
var timer_on = false
var ESCENA_ACTUAL = "MAIN_MENU"
#SEÑALES------------------------------------------------------------
#GENERALES
signal enviar_dardo
	
func notificar_dardo_enviado():
	emit_signal("enviar_dardo")

func modificar_ultimo_dardo(valor):
	ULTIMO_DARDO = valor
	actualizar_sonido_dardo(valor)
	emit_signal("enviar_dardo")
	print(ULTIMO_DARDO)
func actualizar_sonido_dardo(texto):
	var partes = texto.split(":")
	if partes.size() == 2:
		var numero = int(partes[0])
		var letra = partes[1].strip_edges().to_upper()
		SONIDO_DARDO = letra + str(numero)
	if texto == "OUT":
		SONIDO_DARDO = "OUT"
func video(sprite,audio):
	sprite.visible = true
	sprite.play()
	audio.play()


#CONTROL ESCENAS
func _process(delta):
	if Input.is_action_pressed("NEXTPLAYER"):
		if timer_on == false:
			timer_on = true
			siguiente_escena()
			await get_tree().create_timer(0.5).timeout
			timer_on = false
	if Input.is_action_pressed("BACK"):
		if timer_on == false:
			timer_on = true
			anterior_escena()
			await get_tree().create_timer(0.5).timeout
			timer_on = false
func siguiente_escena():
	if ESCENA_ACTUAL == "X01_MENU":
		get_tree().change_scene_to_file("res://Escenas/x_01_GAME.tscn")
	if ESCENA_ACTUAL == "CRICKET_MENU":
		get_tree().change_scene_to_file("res://Escenas/cricket_GAME.tscn")
	if ESCENA_ACTUAL == "HUNDIR_MENU":
		get_tree().change_scene_to_file("res://Escenas/HundirLaFlota_GAME.tscn")
	if ESCENA_ACTUAL == "CONECTA_MENU":
		get_tree().change_scene_to_file("res://Escenas/Conecta4_GAME.tscn")
	if ESCENA_ACTUAL == "PARCHIS_MENU":
		get_tree().change_scene_to_file("res://Escenas/ParchisGAME.tscn")
	if ESCENA_ACTUAL == "FUTBOL_MENU":
		get_tree().change_scene_to_file("res://Escenas/football_GAME.tscn")
	if ESCENA_ACTUAL == "BURMA_MENU":
		get_tree().change_scene_to_file("res://Escenas/burmaGAME.tscn")
func anterior_escena():
	if ESCENA_ACTUAL == "X01_MENU":
		get_tree().change_scene_to_file("res://Escenas/menu.tscn")
	if ESCENA_ACTUAL == "CRICKET_MENU":
		get_tree().change_scene_to_file("res://Escenas/menu.tscn")
	if ESCENA_ACTUAL == "HUNDIR_MENU":
		get_tree().change_scene_to_file("res://Escenas/menu.tscn")
	if ESCENA_ACTUAL == "CONECTA_MENU":
		get_tree().change_scene_to_file("res://Escenas/menu.tscn")
	if ESCENA_ACTUAL == "PARCHIS_MENU":
		get_tree().change_scene_to_file("res://Escenas/menu.tscn")
	if ESCENA_ACTUAL == "FUTBOL_MENU":
		get_tree().change_scene_to_file("res://Escenas/menu.tscn")
	if ESCENA_ACTUAL == "BURMA_MENU":
		get_tree().change_scene_to_file("res://Escenas/menu.tscn")
	if ESCENA_ACTUAL == "AJUSTES":
		get_tree().change_scene_to_file("res://Escenas/menu.tscn")
		
	if ESCENA_ACTUAL == "X01_GAME":
		get_tree().change_scene_to_file("res://Escenas/x01_MODE.tscn")
	if ESCENA_ACTUAL == "CRICKET_GAME":
		get_tree().change_scene_to_file("res://Escenas/cricket_MODE.tscn")
	if ESCENA_ACTUAL == "HUNDIR_GAME":
		get_tree().change_scene_to_file("res://Escenas/HundirLaFlota_MENU.tscn")
	if ESCENA_ACTUAL == "CONECTA_GAME":
		get_tree().change_scene_to_file("res://Escenas/Conecta4_MENU.tscn")
	if ESCENA_ACTUAL == "PARCHIS_GAME":
		get_tree().change_scene_to_file("res://Escenas/ParchisMENU.tscn")
	if ESCENA_ACTUAL == "FUTBOL_GAME":
		get_tree().change_scene_to_file("res://Escenas/football_MENU.tscn")
	if ESCENA_ACTUAL == "BURMA_GAME":
		get_tree().change_scene_to_file("res://Escenas/burmaMENU.tscn")
		

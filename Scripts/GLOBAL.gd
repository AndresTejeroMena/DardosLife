extends Node

# VARIABLES---------------------------------------------------------
#GENERALES
var NUMERO_JUGADORES : int = 2
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
#FUTBOL
var lista_dorsales = [1,2,3,4,5,6,7,8,9,10,11]
var escudo1 = 3
var escudo2 = 7
var camiseta1 = 0
var camiseta2 = 4
var color_local = Color(0,0,0)
var color_visitante = Color(0,0,0)
var lim_rondas = 1000
var lim_goles = 3
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
		print(SONIDO_DARDO)
func video(sprite,audio):
	sprite.visible = true
	sprite.play()
	audio.play()


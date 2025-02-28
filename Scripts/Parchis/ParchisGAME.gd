extends Control
var num_jugadores = GLOBAL.NUMERO_JUGADORES
var puntos = {}
var puntos_inicio_ronda = {}
var puntos_interfaz = {}
var diferencia_interfaz = {}
var dardos = ["", "espera", "espera", "espera"]
var ronda_actual : int = 1
var jugador_actual : int = 1
var puntos_objetivo = GLOBAL.parchis_objetivo

var timer_on = false
@onready var win = $videos/win
@onready var audio = $videos/win/Audio

# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.ESCENA_ACTUAL = "PARCHIS_GAME"
	$Objetivo.text = "Objetivo: "+str(puntos_objetivo)
	var marcador_interfaz = {}
	marcador_interfaz[1] = $Marcadores/J1
	marcador_interfaz[2] = $Marcadores/J2
	marcador_interfaz[3] = $Marcadores/J3
	marcador_interfaz[4] = $Marcadores/J4
	marcador_interfaz[5] = $Marcadores/J5
	marcador_interfaz[6] = $Marcadores/J6
	marcador_interfaz[7] = $Marcadores/J7
	marcador_interfaz[8] = $Marcadores/J8
	for i in range(num_jugadores + 1, 9):
		marcador_interfaz[i].visible = false
	for i in range(1,num_jugadores + 1):
		puntos[i] = 0
		puntos_interfaz[i] = marcador_interfaz[i].get_node("pts")
		diferencia_interfaz[i] = marcador_interfaz[i].get_node("distancia")
	actualizar_marcador()
	iniciar_ronda()

func _process(delta):
	if Input.is_action_pressed("NEXTPLAYER"):
		if timer_on == false:
			timer_on = true
			if $NEXT.disabled == false:
				_on_next_pressed()
				await get_tree().create_timer(0.5).timeout
			timer_on = false
	if Input.is_action_pressed("REWRITE"):
		if timer_on == false:
			timer_on = true
			if $Rewrite.disabled == false:
				_on_rewrite_pressed()
				await get_tree().create_timer(0.5).timeout
			timer_on = false
	if Input.is_action_pressed("OUT"):
		if timer_on == false:
			timer_on = true
			if $Out.disabled == false:
				_on_out_pressed()
				await get_tree().create_timer(0.2).timeout
			timer_on = false
func actualizar_marcador():
	for i in range(1,num_jugadores + 1):
		puntos_interfaz[i].text = str(puntos[i])
		if puntos[i] > puntos[jugador_actual]:
			diferencia_interfaz[i].text = "Dist:"+ str(puntos[i]-puntos[jugador_actual])
		else: diferencia_interfaz[i].text = ""
	$Dardos/dardo1.text = dardos[1]
	$Dardos/dardo2.text = dardos[2]
	$Dardos/dardo3.text = dardos[3]
	
	$Turno/Text.text = "Turno: Jugador "+str(jugador_actual)
	$Turno/pts.text = str(puntos[jugador_actual])
func iniciar_ronda():
	dardos[1] = "espera"
	dardos[2] = "espera"
	dardos[3] = "espera"
	actualizar_marcador()
	puntos_inicio_ronda = puntos.duplicate()
	#print(marcas_inicio_ronda)
	ronda(jugador_actual)
	AUDIOS.playsound("J"+str(jugador_actual))
func ronda(jugador):
	$NEXT.disabled = true
	$Rewrite.disabled = true
	await GLOBAL.enviar_dardo
	dardos[1] = GLOBAL.ULTIMO_DARDO
	check_dardo(GLOBAL.ULTIMO_DARDO,jugador)
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_marcador()
	if check_final(jugador) == true: return
	
	await GLOBAL.enviar_dardo
	dardos[2] = GLOBAL.ULTIMO_DARDO
	check_dardo(GLOBAL.ULTIMO_DARDO,jugador)
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_marcador()
	if check_final(jugador) == true: return
	
	await GLOBAL.enviar_dardo
	dardos[3] = GLOBAL.ULTIMO_DARDO
	check_dardo(GLOBAL.ULTIMO_DARDO,jugador)
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_marcador()
	if check_final(jugador) == true: return
	
	AUDIOS.playsound("NEXT_PLAYER")
	$NEXT.disabled = false
	$Rewrite.disabled = false

func check_dardo(dardo,jugador):
	var puntos_previos = puntos[jugador]
	puntos[jugador] = puntos[jugador] + sacar_puntuacion(dardo,jugador)
	for i in range(1,num_jugadores+1):
		if i == jugador_actual: continue
		if puntos[jugador] == puntos[i]:
			puntos[i]= 0
			AUDIOS.playsound("CORRECTO")
	
func sacar_puntuacion(texto: String,jugador) -> int:
	if texto == ("OUT"):
		return 0
	var partes = texto.split(":")
	if partes.size() == 2:
		var numero = int(partes[0])
		var letra = partes[1].strip_edges().to_upper()
		match letra:
			"S":
				if ((puntos[jugador]==GLOBAL.MODO_PUNTOS)&&(GLOBAL.EMPEZAR_DOBLES == true)):
					return 0
				return numero * 1
			"D":
				return numero * 2
			"T":
				if ((puntos[jugador]==GLOBAL.MODO_PUNTOS)&&(GLOBAL.EMPEZAR_DOBLES == true)):
					return 0
				return numero * 3
			_:
				print("Letra no válida")
				return 0
	else:
		print("Formato no válido")
		return 0

func check_final(jugador):
	if puntos[jugador] == puntos_objetivo:
		final_partida()
		return true
	if puntos[jugador]>puntos_objetivo:
		puntos[jugador] = puntos_objetivo * 2 - puntos[jugador]
		actualizar_marcador()
		AUDIOS.playsound("NEXT_PLAYER")
		$NEXT.disabled = false
		$Rewrite.disabled = false
		return true
		
	return false
func final_partida():
	GLOBAL.video(win,audio)
	

func _on_next_pressed():
	jugador_actual += 1
	if jugador_actual > num_jugadores:
		jugador_actual = 1
		ronda_actual += 1
	iniciar_ronda()
func _on_out_pressed():
	GLOBAL.ULTIMO_DARDO = "OUT"
	GLOBAL.SONIDO_DARDO = "OUT"
	GLOBAL.notificar_dardo_enviado()


func _on_rewrite_pressed():
	puntos = puntos_inicio_ronda.duplicate()
	iniciar_ronda()


func _on_salir_pressed():
	get_tree().change_scene_to_file("res://Escenas/ParchisMENU.tscn")


func _on_win_animation_finished():
	get_tree().change_scene_to_file("res://Escenas/ParchisMENU.tscn")

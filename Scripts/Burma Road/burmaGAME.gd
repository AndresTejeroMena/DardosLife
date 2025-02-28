extends Control
var num_jugadores = GLOBAL.NUMERO_JUGADORES
var puntos = {}
var puntos_inicio_ronda = {}
var puntos_interfaz = {}
var nombres_interfaz = {}
var dardos = ["", "espera", "espera", "espera"]
var ronda_actual : int = 1
var jugador_actual : int = 1
var objetivos_burma = ["15","16","x2","17","18","x3","19","20","25"]
var objetivo_actual = objetivos_burma[0]
var puntos_objetivo = GLOBAL.parchis_objetivo
var aciertos_en_ronda : int = 0
var timer_on = false

@onready var win = $videos/win
@onready var audio = $videos/win/Audio

# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.ESCENA_ACTUAL = "BURMA_GAME"
	$Objetivo/txt.text = objetivo_actual
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
		puntos[i] = 40
		puntos_interfaz[i] = marcador_interfaz[i].get_node("pts")
		nombres_interfaz[i] = marcador_interfaz[i].get_node("nombre")
	actualizar_marcador()
	iniciar_ronda()
func actualizar_marcador():
	for i in range(1,num_jugadores + 1):
		puntos_interfaz[i].text = str(puntos[i])
		puntos_interfaz[i].set("theme_override_colors/font_color",Color(0,0,0))
		nombres_interfaz[i].set("theme_override_colors/font_color",Color(0,0,0))
	$Dardos/dardo1.text = dardos[1]
	$Dardos/dardo2.text = dardos[2]
	$Dardos/dardo3.text = dardos[3]
	
	$TurnoText.text = "Turno: Jugador "+str(jugador_actual)
	puntos_interfaz[jugador_actual].set("theme_override_colors/font_color",Color(1,1,1))
	nombres_interfaz[jugador_actual].set("theme_override_colors/font_color",Color(1,1,1))
	if objetivo_actual == "25":
		$Objetivo/txt.text = "BULL"
	else:
		$Objetivo/txt.text = objetivo_actual
func iniciar_ronda():
	dardos[1] = "espera"
	dardos[2] = "espera"
	dardos[3] = "espera"
	aciertos_en_ronda = 0
	actualizar_marcador()
	puntos_inicio_ronda = puntos.duplicate()
	#print(marcas_inicio_ronda)
	ronda(jugador_actual)
	AUDIOS.playsound("J"+str(jugador_actual))
func ronda(jugador):
	$NEXT.disabled = true
	$Rewrite.disabled = true
	var pts_inicio_ronda = puntos[jugador]
	await GLOBAL.enviar_dardo
	dardos[1] = GLOBAL.ULTIMO_DARDO
	puntos[jugador] = puntos[jugador] + sacar_puntuacion(GLOBAL.ULTIMO_DARDO)
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_marcador()
	
	await GLOBAL.enviar_dardo
	dardos[2] = GLOBAL.ULTIMO_DARDO
	puntos[jugador] = puntos[jugador] + sacar_puntuacion(GLOBAL.ULTIMO_DARDO)
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_marcador()
	
	await GLOBAL.enviar_dardo
	dardos[3] = GLOBAL.ULTIMO_DARDO
	puntos[jugador] = puntos[jugador] + sacar_puntuacion(GLOBAL.ULTIMO_DARDO)
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	if pts_inicio_ronda == puntos[jugador]:
		if puntos[jugador] != 1:
			puntos[jugador] = puntos[jugador]/2
			AUDIOS.playsound("FALLO_BOB")
	actualizar_marcador()
	
	AUDIOS.playsound("NEXT_PLAYER")
	if (jugador_actual == GLOBAL.NUMERO_JUGADORES) && (ronda_actual == 9):
		final_partida()
	else:
		$NEXT.disabled = false
		$Rewrite.disabled = false
	

	
func sacar_puntuacion(texto: String) -> int:
	if texto == ("OUT"):
		return 0
	var partes = texto.split(":")
	if partes.size() == 2:
		var numero = int(partes[0])
		var letra = partes[1].strip_edges().to_upper()
		if objetivo_actual == str(numero):
			match letra:
				"S":
					return numero * 1
					AUDIOS.playsound("CORRECTO")
				"D":
					return numero * 2
					AUDIOS.playsound("CORRECTO")
				"T":
					return numero * 3
					AUDIOS.playsound("CORRECTO")
				_:
					print("Letra no válida")
					return 0
		if objetivo_actual == "x2":
			if letra == "D":
				return numero * 2
				AUDIOS.playsound("CORRECTO")
		if objetivo_actual == "x3":
			if letra == "T":
				return numero * 3
				AUDIOS.playsound("CORRECTO")
		else:
			return 0
	else:
		print("Formato no válido")
		return 0
	return 0

func final_partida():
	var ganador : int = 1
	var puntos_max : int = 0
	for i in range(1,num_jugadores + 1):
		if puntos[i] > puntos_max:
			ganador = i
	$TxtGanador.text = "¡Gana el Jugador "+str(ganador)+"!"
	$TxtGanador.visible = true
	GLOBAL.video(win,audio)
	

func _on_next_pressed():
	jugador_actual += 1
	if jugador_actual > num_jugadores:
		jugador_actual = 1
		ronda_actual += 1
		objetivo_actual = objetivos_burma[ronda_actual-1]
	iniciar_ronda()
func _on_out_pressed():
	GLOBAL.ULTIMO_DARDO = "OUT"
	GLOBAL.SONIDO_DARDO = "OUT"
	GLOBAL.notificar_dardo_enviado()


func _on_rewrite_pressed():
	puntos = puntos_inicio_ronda.duplicate()
	iniciar_ronda()


func _on_salir_pressed():
	get_tree().change_scene_to_file("res://Escenas/burmaMENU.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
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


func _on_win_animation_finished():
	get_tree().change_scene_to_file("res://Escenas/burmaMENU.tscn")

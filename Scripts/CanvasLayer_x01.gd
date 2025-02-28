extends CanvasLayer
var ronda_actual: int = 1
var puntos = [0, 999, 999, 999, 999, 999, 999, 999, 999]
var puntos_inicio_ronda = []
var jugador_actual: int = 1
var dardos = ["", "espera", "espera", "espera"]
var fue_doble: bool = false
var timer_on = false
@onready var win = $videos/win
@onready var audio = $videos/win/Audio

# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.ESCENA_ACTUAL = "X01_GAME"
	$TextureRect.visible = false
	$Leyenda_modo/Label_x01.text = str(GLOBAL.MODO_PUNTOS)
	$Leyenda_modo/Label_empezar.text = str(GLOBAL.EMPEZAR_DOBLES)
	$Leyenda_modo/Label_acabar.text = str(GLOBAL.ACABAR_DOBLES)
	$Leyenda_modo/Label_numerojugadores.text = str(GLOBAL.NUMERO_JUGADORES)
	for i in range(1, GLOBAL.NUMERO_JUGADORES + 1):
		puntos[i] = GLOBAL.MODO_PUNTOS
	actualizar_marcadores()
	empezar_partida()
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
func actualizar_marcadores():
	var marcadores = [$Leyenda_jugadores/pts_centrales, $Leyenda_jugadores/ptsj1, $Leyenda_jugadores/ptsj2,
					  $Leyenda_jugadores/ptsj3, $Leyenda_jugadores/ptsj4, $Leyenda_jugadores/ptsj5,
					  $Leyenda_jugadores/ptsj6, $Leyenda_jugadores/ptsj7, $Leyenda_jugadores/ptsj8]
	for i in range(1, 9):
		if puntos[i] == 999:
			marcadores[i].text = str("X")
		else:
			marcadores[i].text = str(puntos[i])
	marcadores[0].text = str(puntos[jugador_actual])
	$Leyenda_jugadores/Leyenda_jugador/numero_jugador.text = str(jugador_actual)
	$Dardos/dardo1.text = dardos[1]
	$Dardos/dardo2.text = dardos[2]
	$Dardos/dardo3.text = dardos[3]
	$Leyenda_modo/Label_RondaActual.text = str(ronda_actual)
	if dardos[3] != "espera":#si no quedan dardos
		$tabla_dobles.text = ""
		$TextureRect.visible = false
	elif dardos[2] != "espera":#si queda un dardo
		if puntos[jugador_actual] in TablaCierres.un_dardo:
			$tabla_dobles.text = TablaCierres.un_dardo[puntos[jugador_actual]]
			$TextureRect.visible = true
		else:
			$tabla_dobles.text = ""
			$TextureRect.visible = false
	elif dardos[1] != "espera":#si quedan dos dardos
		if puntos[jugador_actual] in TablaCierres.un_dardo:
			$tabla_dobles.text = TablaCierres.un_dardo[puntos[jugador_actual]]
			$TextureRect.visible = true
		elif puntos[jugador_actual] in TablaCierres.dos_dardos:
			$tabla_dobles.text = TablaCierres.dos_dardos[puntos[jugador_actual]]
			$TextureRect.visible = true
		else:
			$tabla_dobles.text = ""
			$TextureRect.visible = false
	else:#si quedan 3 dardos
		if puntos[jugador_actual] in TablaCierres.un_dardo:
			$tabla_dobles.text = TablaCierres.un_dardo[puntos[jugador_actual]]
			$TextureRect.visible = true
		elif puntos[jugador_actual] in TablaCierres.dos_dardos:
			$tabla_dobles.text = TablaCierres.dos_dardos[puntos[jugador_actual]]
			$TextureRect.visible = true
		elif puntos[jugador_actual] in TablaCierres.tres_dardos:
			$tabla_dobles.text = TablaCierres.tres_dardos[puntos[jugador_actual]]
			$TextureRect.visible = true
		else:
			$tabla_dobles.text = ""
			$TextureRect.visible = false
func empezar_partida():
	ronda_actual = 1
	jugador_actual = 1
	iniciar_ronda()

func iniciar_ronda():
	$NEXT.disabled = true
	$Rewrite.disabled = true
	dardos[1] = "espera"
	dardos[2] = "espera"
	dardos[3] = "espera"
	fue_doble = false
	actualizar_marcadores()
	puntos_inicio_ronda = puntos.duplicate()
	ronda(jugador_actual)
	AUDIOS.playsound("J"+str(jugador_actual))
	

func ronda(jugador):
	await GLOBAL.enviar_dardo
	dardos[1] = GLOBAL.ULTIMO_DARDO
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	puntos[jugador] = puntos[jugador] - sacar_puntuacion(GLOBAL.ULTIMO_DARDO,jugador)
	actualizar_marcadores()
	if check_final_ronda(jugador) == true: return
	
	await GLOBAL.enviar_dardo
	dardos[2] = GLOBAL.ULTIMO_DARDO
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	puntos[jugador] = puntos[jugador] - sacar_puntuacion(GLOBAL.ULTIMO_DARDO,jugador)
	actualizar_marcadores()
	if check_final_ronda(jugador) == true: return
	
	await GLOBAL.enviar_dardo
	dardos[3] = GLOBAL.ULTIMO_DARDO
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	puntos[jugador] = puntos[jugador] - sacar_puntuacion(GLOBAL.ULTIMO_DARDO,jugador)
	actualizar_marcadores()
	if check_final_ronda(jugador) == true: return
	
	AUDIOS.playsound("NEXT_PLAYER")
	$NEXT.disabled = false
	$Rewrite.disabled = false

func check_final_ronda(jugador):
	if((puntos[jugador]==1)&&GLOBAL.ACABAR_DOBLES == true):
		actualizar_marcadores()
		puntos[jugador] = puntos[jugador] + sacar_puntuacion(GLOBAL.ULTIMO_DARDO,jugador)
		AUDIOS.playsound("NEXT_PLAYER")
		$NEXT.disabled = false
		$Rewrite.disabled = false
		return true
	if (puntos[jugador] <0): #si te pasas
		puntos[jugador] = puntos[jugador] + sacar_puntuacion(GLOBAL.ULTIMO_DARDO,jugador)
		actualizar_marcadores()
		AUDIOS.playsound("NEXT_PLAYER")
		$NEXT.disabled = false
		$Rewrite.disabled = false
		return true
	elif ((puntos[jugador]==0)&&(GLOBAL.ACABAR_DOBLES == true)): #modo dobles 0
		var partes = GLOBAL.ULTIMO_DARDO.split(":")
		if partes[1].strip_edges().to_upper() == "D":
			final_partida()
			return true
		else:
			puntos[jugador] = puntos[jugador] + sacar_puntuacion(GLOBAL.ULTIMO_DARDO,jugador)
			actualizar_marcadores()
			AUDIOS.playsound("NEXT_PLAYER")
			$NEXT.disabled = false
			$Rewrite.disabled = false
			return true
	elif ((puntos[jugador]==0)&&(GLOBAL.ACABAR_DOBLES == false)):
		final_partida()
		return true
	else:
		return false
	

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
				fue_doble = false
				return numero * 1
			"D":
				fue_doble = true
				return numero * 2
			"T":
				if ((puntos[jugador]==GLOBAL.MODO_PUNTOS)&&(GLOBAL.EMPEZAR_DOBLES == true)):
					return 0
				fue_doble = false
				return numero * 3
			_:
				print("Letra no válida")
				return 0
	else:
		print("Formato no válido")
		return 0

func _on_rewrite_pressed():
	print(puntos_inicio_ronda)
	puntos = puntos_inicio_ronda.duplicate()
	iniciar_ronda()
func _on_next_pressed():
	jugador_actual += 1
	if jugador_actual > GLOBAL.NUMERO_JUGADORES:
		jugador_actual = 1
		ronda_actual += 1
	iniciar_ronda()
func _on_out_pressed():
	GLOBAL.ULTIMO_DARDO = "OUT"
	GLOBAL.SONIDO_DARDO = "OUT"
	GLOBAL.notificar_dardo_enviado()


func final_partida():
	GLOBAL.video(win,audio)
func _on_salir_pressed():
	get_tree().change_scene_to_file("res://Escenas/x01_MODE.tscn")
func _on_win_animation_finished():
	get_tree().change_scene_to_file("res://Escenas/x01_MODE.tscn")

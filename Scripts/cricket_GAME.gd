extends Control
var dardos = ["", "espera", "espera", "espera"]
var ronda_actual : int = 1
var jugador_actual : int = 1
var puntos = [0, -1, -1, -1, -1, -1, -1, -1, -1]
var marcas : Array = [] #marcas[jugador][objetivo(0-6)]
var puntos_inicio_ronda = []
var marcas_inicio_ronda = []
var timer_on = false
@onready var win = $CanvasLayer/videos/win
@onready var audio = $CanvasLayer/videos/win/Audio

# Called when the node enters the scene tree for the first time.
func _ready():
	$Leyenda_modo/Label_modo.text = GLOBAL.MODO_CRICKET
	$Leyenda_modo/Label_cut_thorat.text = str(GLOBAL.cutthroat)
	$Leyenda_modo/Label_numerojugadores.text = str(GLOBAL.NUMERO_JUGADORES)
	$Leyenda_modo/Label_RondaActual.text = str(ronda_actual)
	$Leyenda_modo/Turno_jugador.text = str(jugador_actual)
	$CanvasLayer/Objetivos/N1.text = str(GLOBAL.objetivos_cricket[0])
	$CanvasLayer/Objetivos/N2.text = str(GLOBAL.objetivos_cricket[1])
	$CanvasLayer/Objetivos/N3.text = str(GLOBAL.objetivos_cricket[2])
	$CanvasLayer/Objetivos/N4.text = str(GLOBAL.objetivos_cricket[3])
	$CanvasLayer/Objetivos/N5.text = str(GLOBAL.objetivos_cricket[4])
	$CanvasLayer/Objetivos/N6.text = str(GLOBAL.objetivos_cricket[5])
	
	for i in range(1, GLOBAL.NUMERO_JUGADORES + 1):
		puntos[i] = 0
	for i in range(9):
		var fila : Array = []
		for j in range(7):
			fila.append(0)
		marcas.append(fila)
	actualizar_marcadores()
	empezar_partida()
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if timer_on == false:
			timer_on = true
			if $NEXT.disabled == false:
				_on_next_pressed()
				await get_tree().create_timer(0.5).timeout
				timer_on = false
	if Input.is_action_pressed("ui_cancel"):
		if timer_on == false:
			timer_on = true
			if $Rewrite.disabled == false:
				_on_rewrite_pressed()
				await get_tree().create_timer(0.5).timeout
				timer_on = false
	if Input.is_action_pressed("ui_focus_next"):
		if timer_on == false:
			timer_on = true
			if $Out.disabled == false:
				_on_out_pressed()
				await get_tree().create_timer(0.2).timeout
				timer_on = false
func actualizar_marcadores():
	$Leyenda_modo/Label_RondaActual.text = str(ronda_actual)
	$Leyenda_modo/Turno_jugador.text = str(jugador_actual)
	$CanvasLayer/Dardos/dardo1.text = dardos[1]
	$CanvasLayer/Dardos/dardo2.text = dardos[2]
	$CanvasLayer/Dardos/dardo3.text = dardos[3]
	var marcadores_puntos = [$CanvasLayer/Pts,$CanvasLayer/Pts/J1,$CanvasLayer/Pts/J2,$CanvasLayer/Pts/J3,$CanvasLayer/Pts/J4,$CanvasLayer/Pts/J5,$CanvasLayer/Pts/J6,$CanvasLayer/Pts/J7,$CanvasLayer/Pts/J8]
	for i in range(1, 9):
		if puntos[i] == -1:
			marcadores_puntos[i].text = str("X")
		else:
			marcadores_puntos[i].text = str(puntos[i])
	actualizar_marcas()
func actualizar_marcas():
	var imag_marcas = [[$CanvasLayer/J1/N1,$CanvasLayer/J1/N2,$CanvasLayer/J1/N3,$CanvasLayer/J1/N4,$CanvasLayer/J1/N5,$CanvasLayer/J1/N6,$CanvasLayer/J1/N7],[$CanvasLayer/J2/N1,$CanvasLayer/J2/N2,$CanvasLayer/J2/N3,$CanvasLayer/J2/N4,$CanvasLayer/J2/N5,$CanvasLayer/J2/N6,$CanvasLayer/J2/N7],[$CanvasLayer/J3/N1,$CanvasLayer/J3/N2,$CanvasLayer/J3/N3,$CanvasLayer/J3/N4,$CanvasLayer/J3/N5,$CanvasLayer/J3/N6,$CanvasLayer/J3/N7],[$CanvasLayer/J4/N1,$CanvasLayer/J4/N2,$CanvasLayer/J4/N3,$CanvasLayer/J4/N4,$CanvasLayer/J4/N5,$CanvasLayer/J4/N6,$CanvasLayer/J4/N7],[$CanvasLayer/J5/N1,$CanvasLayer/J5/N2,$CanvasLayer/J5/N3,$CanvasLayer/J5/N4,$CanvasLayer/J5/N5,$CanvasLayer/J5/N6,$CanvasLayer/J5/N7],[$CanvasLayer/J6/N1,$CanvasLayer/J6/N2,$CanvasLayer/J6/N3,$CanvasLayer/J6/N4,$CanvasLayer/J6/N5,$CanvasLayer/J6/N6,$CanvasLayer/J6/N7],[$CanvasLayer/J7/N1,$CanvasLayer/J7/N2,$CanvasLayer/J7/N3,$CanvasLayer/J7/N4,$CanvasLayer/J7/N5,$CanvasLayer/J7/N6,$CanvasLayer/J7/N7],[$CanvasLayer/J8/N1,$CanvasLayer/J8/N2,$CanvasLayer/J8/N3,$CanvasLayer/J8/N4,$CanvasLayer/J8/N5,$CanvasLayer/J8/N6,$CanvasLayer/J8/N7]]
	for i in range(9):
		for j in range(7):
			imag_marcas[i-1][j].frame = marcas[i][j]

func empezar_partida():
	ronda_actual = 1
	jugador_actual = 1
	iniciar_ronda()

func iniciar_ronda():
	dardos[1] = "espera"
	dardos[2] = "espera"
	dardos[3] = "espera"
	actualizar_marcadores()
	puntos_inicio_ronda = puntos.duplicate()
	marcas_inicio_ronda = deep_duplicate(marcas)
	print(marcas_inicio_ronda)
	ronda(jugador_actual)
	AUDIOS.playsound("J"+str(jugador_actual))

func ronda(jugador):
	$NEXT.disabled = true
	$Rewrite.disabled = true
	await GLOBAL.enviar_dardo
	dardos[1] = GLOBAL.ULTIMO_DARDO
	check_dardo(GLOBAL.ULTIMO_DARDO,jugador)
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_marcadores()
	if check_final(jugador) == true: return
	
	await GLOBAL.enviar_dardo
	dardos[2] = GLOBAL.ULTIMO_DARDO
	check_dardo(GLOBAL.ULTIMO_DARDO,jugador)
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_marcadores()
	if check_final(jugador) == true: return
	
	await GLOBAL.enviar_dardo
	dardos[3] = GLOBAL.ULTIMO_DARDO
	check_dardo(GLOBAL.ULTIMO_DARDO,jugador)
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_marcadores()
	if check_final(jugador) == true: return
	
	$NEXT.disabled = false
	$Rewrite.disabled = false

func check_dardo(texto: String, jugador):
	if texto == ("OUT"):
		return

	var partes = texto.split(":")
	if partes.size() == 2:
		var numero = int(partes[0])
		var letra = partes[1].strip_edges().to_upper()
		var sumar_marcas : int = 0
		var sumador : int = 0
		# Comprobar si el número está en objetivos_cricket
		if numero in GLOBAL.objetivos_cricket:
			var indice = GLOBAL.objetivos_cricket.find(numero)
			match letra:
				"S":
					sumar_marcas = 1
				"D":
					sumar_marcas = 2
				"T":
					sumar_marcas = 3
			marcas[jugador][indice] += sumar_marcas
			if marcas[jugador][indice]>3:
				sumador = ((marcas[jugador][indice] - 3)*GLOBAL.objetivos_cricket[indice])
				marcas[jugador][indice] = 3
				if GLOBAL.cutthroat == true:
					for i in range(1, GLOBAL.NUMERO_JUGADORES + 1):
						if marcas[i][indice] != 3:
							puntos[i] += sumador
				else:#no cut throat
					var todos_cerrados :bool = true
					for i in range(1, GLOBAL.NUMERO_JUGADORES + 1):
						if marcas[i][indice] != 3:
							todos_cerrados = false
					if todos_cerrados == false:
						puntos[jugador] += sumador
		else:
			return

func check_final(jugador):
	var todo_cerrado = true
	var gana = true
	for i in range(0, 7):
		if marcas[jugador][i] != 3:
			todo_cerrado = false
	if todo_cerrado == true:
		if GLOBAL.cutthroat == true: #modo cut throat
			for i in range(1, GLOBAL.NUMERO_JUGADORES + 1):
				if (puntos[i]<puntos[jugador]):
					gana = false
		if GLOBAL.cutthroat == false: #modo cut throat
			for i in range(1, GLOBAL.NUMERO_JUGADORES + 1):
				if (puntos[i]>puntos[jugador]):
					gana = false
		if GLOBAL.NUMERO_JUGADORES == 1: gana = true
		if gana == true:
			final_partida()
				
func _on_next_pressed():
	jugador_actual += 1
	if jugador_actual > GLOBAL.NUMERO_JUGADORES:
		jugador_actual = 1
		ronda_actual += 1
	iniciar_ronda()
func _on_out_pressed():
	GLOBAL.ULTIMO_DARDO = "OUT"
	GLOBAL.notificar_dardo_enviado()


func _on_rewrite_pressed():
	puntos = puntos_inicio_ronda.duplicate()
	marcas = deep_duplicate(marcas_inicio_ronda)
	iniciar_ronda()
func deep_duplicate(arr):
	var duplicate = []
	for i in arr:
		if typeof(i) == TYPE_ARRAY:
			duplicate.append(deep_duplicate(i))
		else:
			duplicate.append(i)
	return duplicate

func final_partida():
	GLOBAL.video(win,audio)
	
func _on_salir_pressed():
	get_tree().change_scene_to_file("res://Escenas/cricket_MODE.tscn")


func _on_win_animation_finished():
	get_tree().change_scene_to_file("res://Escenas/cricket_MODE.tscn")

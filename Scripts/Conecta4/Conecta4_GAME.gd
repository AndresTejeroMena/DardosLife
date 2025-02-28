extends Control

var dardos = ["", "espera", "espera", "espera"]
var ronda_actual : int = 1
var jugador_actual : int = 1
var timer_on = false

var numeros_conecta4 = GLOBAL.objetivos_conecta4
var marcas_numeros = {} #lista de labels para escribir el numero de los objetivos en pantalla
var marcas = {} #numero de impactos en esa marca (-3 cae ficha roja, +3 cae ficha amarilla)
var sprite_marcas = {} #sprite correspondiente a las marcas con 7 frames (0-6)
var fichas := {}
var pos_inicial = {} 
var destinos = {}
var col_completa = [false,false,false,false,false,false,false,false]

var destinos_inicio_ronda = {}
var marcas_inicio_ronda = {}
var frame_fichas_inicio_ronda = {}

@onready var win_rojo = $"videos/win rojo"
@onready var win_amarillo = $"videos/win amarillo"
@onready var audio = $"videos/win rojo/Audio"

func _ready():
	GLOBAL.ESCENA_ACTUAL = "CONECTA_GAME"
	preparar_fichas()
	preparar_marcas()
	empezar_partida()
	actualizar_marcador()
	print(GLOBAL.objetivos_conecta4)
func _process(delta):
	for i in range(1, 7):
		for j in range(1, 8):  # Mantenemos el rango de 1 a 7
			if typeof(fichas[i][j]) != TYPE_NIL:
				if typeof(destinos[i][j]) != TYPE_NIL:
					
					if fichas[i][j].global_position != destinos[i][j]:
						mover(delta, i, j)
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
func mover(delta, i, j):
	var speed = 300
	fichas[i][j].global_position = fichas[i][j].global_position.move_toward(destinos[i][j], delta * speed)
func preparar_fichas():
	var destino = {}
	destino[0] = $"punto_partida/1".global_position
	destino[1] = $"punto_partida/1".global_position
	destino[2] = $"punto_partida/2".global_position
	destino[3] = $"punto_partida/3".global_position
	destino[4] = $"punto_partida/4".global_position
	destino[5] = $"punto_partida/5".global_position
	destino[6] = $"punto_partida/6".global_position
	destino[7] = $"punto_partida/7".global_position
	
	fichas[0] = []
	fichas[1] = []
	fichas[2] = []
	fichas[3] = []
	fichas[4] = []
	fichas[5] = []
	fichas[6] = []
	
	frame_fichas_inicio_ronda[0] = []
	frame_fichas_inicio_ronda[1] = []
	frame_fichas_inicio_ronda[2] = []
	frame_fichas_inicio_ronda[3] = []
	frame_fichas_inicio_ronda[4] = []
	frame_fichas_inicio_ronda[5] = []
	frame_fichas_inicio_ronda[6] = []
	
	# Llena la matriz con coordenadas
	for i in range(0, 7):
		destinos[i] = []
		destinos_inicio_ronda[i] = []
		for j in range(0, 8):
			# Agrega las coordenadas (x, y) a cada elemento de la matriz
			destinos[i].append([i, j])
			destinos_inicio_ronda[i].append([i,j])
			

	# Itera sobre los contenedores y almacena los sprites en el diccionario
	for i in range(1, 7):
		var container_fichas = null
		match i:
			1: container_fichas = $Fichas/Fila1
			2: container_fichas = $Fichas/Fila2
			3: container_fichas = $Fichas/Fila3
			4: container_fichas = $Fichas/Fila4
			5: container_fichas = $Fichas/Fila5
			6: container_fichas = $Fichas/Fila6
		fichas[i].append("")
		frame_fichas_inicio_ronda[i].append("")
		destinos[i] = []  # Inicializa destinos[i] como un array vacío
		destinos[i].append("")
		if container_fichas:
			for j in range(1, 8):  # Mantenemos el rango de 1 a 7
				var sprite_name = str(j)  # Nombre del sprite
				var ficha_sprite = container_fichas.get_node(sprite_name)
				pos_inicial[ficha_sprite] = ficha_sprite.global_position
				destinos[i].append(destino[j])  # Agrega destino[j] a destinos[i]
				if ficha_sprite:
					fichas[i].append(ficha_sprite)
					frame_fichas_inicio_ronda[i].append(int(2))
	# invisibilizar fichas
	for i in range(1, 7):
		for j in range(1, 8):
			fichas[i][j].frame = 2
			fichas[i][j].visible = false
	

func preparar_marcas():
	sprite_marcas[0] = ""
	sprite_marcas[1] = $Marcas/Casilla1/marcas
	sprite_marcas[2] = $Marcas/Casilla2/marcas
	sprite_marcas[3] = $Marcas/Casilla3/marcas
	sprite_marcas[4] = $Marcas/Casilla4/marcas
	sprite_marcas[5] = $Marcas/Casilla5/marcas
	sprite_marcas[6] = $Marcas/Casilla6/marcas
	sprite_marcas[7] = $Marcas/Casilla7/marcas
	
	marcas_numeros[0] = ""
	marcas_numeros[1] = $Marcas/Casilla1/Label
	marcas_numeros[2] = $Marcas/Casilla2/Label
	marcas_numeros[3] = $Marcas/Casilla3/Label
	marcas_numeros[4] = $Marcas/Casilla4/Label
	marcas_numeros[5] = $Marcas/Casilla5/Label
	marcas_numeros[6] = $Marcas/Casilla6/Label
	marcas_numeros[7] = $Marcas/Casilla7/Label
	
	marcas_inicio_ronda[0] = 0
	marcas[0] = 0
	for i in range(1,8):
		marcas_inicio_ronda[i] = 0
		marcas[i] = 0
		sprite_marcas[i].frame = 3
		marcas_numeros[i].text = str(numeros_conecta4[i])

func empezar_partida():
	ronda_actual = 1
	jugador_actual = 1
	iniciar_ronda()

func iniciar_ronda():
	dardos[1] = "espera"
	dardos[2] = "espera"
	dardos[3] = "espera"
	guardar_datos_inicio_ronda()
	actualizar_marcador()
	ronda(jugador_actual)
	AUDIOS.playsound("J"+str(jugador_actual))

func ronda(jugador):
	$NEXT.disabled = true
	$Rewrite.disabled = true
	await GLOBAL.enviar_dardo
	dardos[1] = GLOBAL.ULTIMO_DARDO
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_marcador()
	check_dardo(GLOBAL.ULTIMO_DARDO,jugador)
	
	await GLOBAL.enviar_dardo
	dardos[2] = GLOBAL.ULTIMO_DARDO
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_marcador()
	check_dardo(GLOBAL.ULTIMO_DARDO,jugador)
	
	await GLOBAL.enviar_dardo
	dardos[3] = GLOBAL.ULTIMO_DARDO
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_marcador()
	check_dardo(GLOBAL.ULTIMO_DARDO,jugador)
	if check_final(jugador) == false:
		AUDIOS.playsound("NEXT_PLAYER")
	$NEXT.disabled = false
	$Rewrite.disabled = false

func check_dardo(texto: String, jugador):
	if texto == ("OUT"):
		return
	var partes = texto.split(":")
	if partes.size() == 2:
		var numero = int(partes[0])
		var letra = partes[1].strip_edges().to_upper()
		var impactos : int = 0
		# Comprobar si el número está en objetivos_cricket
		if numero in numeros_conecta4:
			var indice = numeros_conecta4.find(numero)
			match letra:
				"S":
					impactos = 1
				"D":
					impactos = 2
				"T":
					impactos = 3
			if col_completa[indice] == true: return
			if jugador == 1: marcas[indice] -= impactos
			if jugador == 2: marcas[indice] += impactos
			if marcas[indice] >=3: tirar_ficha(indice,jugador)
			elif marcas[indice] <=-3: tirar_ficha(indice,jugador)
			else: sprite_marcas[indice].frame = marcas[indice] + 3
	return
func tirar_ficha(j,jugador):
	AUDIOS.playsound("CORRECTO")
	var fila
	for i in range(1,7):
		if fichas[i][j].frame == 2:#si no es 2 es que es invisible, es decir aun no se ha puesto la ficha
			fila = i
			break
	if fila >= 6: 
		col_completa[j]=true
	fichas[fila][j].visible = true
	if jugador == 1:
		fichas[fila][j].frame = int(0) #rojo
		marcas[j] +=3
		sprite_marcas[j].frame = 0
	if jugador == 2:
		fichas[fila][j].frame = int(1) #amarillo
		marcas[j] -=3
		sprite_marcas[j].frame = 6
	destinos[fila][j] = pos_inicial[fichas[fila][j]]
	await get_tree().create_timer(0.2).timeout
	sprite_marcas[j].frame = marcas[j] + 3
	await get_tree().create_timer(1.5).timeout
	if check_final(jugador) == true: 
		final_partida(jugador)

func check_final(jugador):	
	# Verificar horizontalmente
	for row in range(1,7):
		for col in range(1,5):
			if fichas[row][col].frame !=2:
				if fichas[row][col].frame == fichas[row][col + 1].frame:
					if fichas[row][col + 1].frame  == fichas[row][col + 2].frame:
						if fichas[row][col + 2].frame  == fichas[row][col + 3].frame:
							return true

	# Verificar verticalmente
	for col in range(1,8):
		for row in range(1,4):
			if fichas[row][col].frame !=2:
				if fichas[row][col].frame  == fichas[row + 1][col].frame:
					if fichas[row + 1][col].frame  == fichas[row + 2][col].frame :
						if fichas[row + 2][col].frame  == fichas[row + 3][col].frame :
							return true

	# Verificar diagonalmente (de izquierda a derecha)
	for row in range(1,4):
		for col in range(1,5):
			if fichas[row][col].frame !=2:
				if fichas[row][col].frame  == fichas[row + 1][col + 1].frame:
					if fichas[row + 1][col + 1].frame  == fichas[row + 2][col + 2].frame :
						if fichas[row + 2][col + 2].frame  == fichas[row + 3][col + 3].frame :
							return true

	# Verificar diagonalmente (de derecha a izquierda)
	for row in range(1,4):
		for col in range(4, 8):
			if fichas[row][col].frame !=2:
				if fichas[row][col].frame  == fichas[row + 1][col - 1].frame:
					if fichas[row + 1][col - 1].frame  == fichas[row + 2][col - 2].frame :
						if fichas[row + 2][col - 2].frame  == fichas[row + 3][col - 3].frame :
							return true

	return false

func actualizar_marcador():
	$Leyenda/Ronda.text = str(ronda_actual)
	if (jugador_actual == 1): 
		$Leyenda/color.frame = 0
	if (jugador_actual == 2): 
		$Leyenda/color.frame = 1
	$Dardos/dardo1.text = dardos[1]
	$Dardos/dardo2.text = dardos[2]
	$Dardos/dardo3.text = dardos[3]
func _on_next_pressed():
	jugador_actual += 1
	if jugador_actual > 2:
		jugador_actual = 1
		ronda_actual += 1
	iniciar_ronda()
func _on_out_pressed():
	GLOBAL.ULTIMO_DARDO = "OUT"
	GLOBAL.SONIDO_DARDO = "OUT"
	GLOBAL.notificar_dardo_enviado()
func _on_rewrite_pressed():
	for i in range(1, 7):
		for j in range(1, 8):
			marcas[j] = marcas_inicio_ronda[j]
			destinos[i][j] = destinos_inicio_ronda[i][j]
			fichas[i][j].frame = frame_fichas_inicio_ronda[i][j]
	for i in range(1,8):
		sprite_marcas[i].frame = marcas[i] + 3
	iniciar_ronda()
func guardar_datos_inicio_ronda():
	for i in range(1, 7):
		for j in range(1, 8):
			marcas_inicio_ronda[j] = marcas[j]
			frame_fichas_inicio_ronda[i][j] = fichas[i][j].frame
			destinos_inicio_ronda[i][j] = destinos[i][j]

func final_partida(jugador):
	if jugador == 1: GLOBAL.video(win_rojo,audio)
	else: GLOBAL.video(win_amarillo,audio)
func _on_salir_pressed():
	get_tree().change_scene_to_file("res://Escenas/Conecta4_MENU.tscn")
func _on_win_rojo_animation_finished():
	get_tree().change_scene_to_file("res://Escenas/Conecta4_MENU.tscn")
func _on_win_amarillo_animation_finished():
	get_tree().change_scene_to_file("res://Escenas/Conecta4_MENU.tscn")

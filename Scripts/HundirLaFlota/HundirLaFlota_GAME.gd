extends Control

var T1 := {} #Equipo1[1=s,2=D,3=T][numero]
var T2 := {}#Equipo2

var sec_numeros = [20, 1, 18, 4, 13, 6, 10, 15, 2, 17, 3, 19, 7, 16, 8, 11, 14, 9, 12, 5]
var sec_tipo = [0,1,2,3,0]

var radar =GLOBAL.radar
var portaviones = GLOBAL.portaviones
var acorazado =GLOBAL.acorazado
var crucero =GLOBAL.crucero
var destructores =GLOBAL.destructores
var submarinos =GLOBAL.submarinos
var hay_barco = {} #true si hay barco
var id_barco = {} #id del barco
var impactos_T1 = 0
var impactos_T2 = 0
var total_objetivos = submarinos + 2*destructores + 3*crucero + 4*acorazado + 5*portaviones
var id_unico : int = 0
var dardos = ["", "espera", "espera", "espera"]
var ronda_actual : int = 1
var equipo_actual 
var jugador_actual: int = 1
var frames_inicio_ronda = {}

var timer_on = false

@onready var win = $win
@onready var audio = $win/Audio


# Called when the node enters the scene tree for the first time.
func _ready():
	init_marcas()
	generar_barcos()
	empezar_partida()
		
func init_marcas():
	var triples_T1 = $T1/Triples
	var simples_T1 = $T1/Simples
	var dobles_T1 = $T1/Dobles
	var triples_T2 = $T2/Triples
	var simples_T2 = $T2/Simples
	var dobles_T2 = $T2/Dobles
	
	# Almacena los sprites de T1 en un diccionario
	T1[3] = []
	T1[2] = []
	T1[1] = []

	# Almacena los sprites de T2 en un diccionario
	T2[3] = []
	T2[2] = []
	T2[1] = []
	
	frames_inicio_ronda[1] = []
	frames_inicio_ronda[2] = []
	frames_inicio_ronda[3] = []

	# Itera sobre los contenedores y almacena los sprites en el diccionario
	for i in range(1, 4):
		var container_T1 = null
		var container_T2 = null
		match i:
			3: # Triples
				container_T1 = triples_T1
				container_T2 = triples_T2
			2: # Dobles
				container_T1 = dobles_T1
				container_T2 = dobles_T2
			1: # Simples
				container_T1 = simples_T1
				container_T2 = simples_T2
		
		T1[i].append("")
		T2[i].append("")
		frames_inicio_ronda[i].append(0)
		if container_T1 and container_T2:
			for j in range(1, 21):
				var sprite_name = str(j)
				var T1_sprite = container_T1.get_node(sprite_name)
				var T2_sprite = container_T2.get_node(sprite_name)
				hay_barco[T1_sprite] = false
				hay_barco[T2_sprite] = false
				id_barco[T1_sprite] = 0
				id_barco[T2_sprite] = 0

				if T1_sprite and T2_sprite:
					T1[i].append(T1_sprite)
					T2[i].append(T2_sprite)
					frames_inicio_ronda[i].append(0)
func generar_barcos():
	for i in range(submarinos):
		generar_barco(1,T1)
		generar_barco(1,T2)
	for i in range(destructores):
		generar_barco(2,T1)
		generar_barco(2,T2)
	for i in range(crucero):
		generar_barco(3,T1)
		generar_barco(3,T2)
	for i in range(acorazado):
		generar_barco(4,T1)
		generar_barco(4,T2)
	for i in range(portaviones):
		generar_barco(5,T1)
		generar_barco(5,T2)
func generar_barco(long,T):
	while true:
		var equipo = T
		var fila_aleatoria = randi() % 3 + 1
		var columna_aleatoria = randi() % 20 + 1
		#print(typeof(columna_aleatoria))
		if hay_barco[equipo[fila_aleatoria][columna_aleatoria]] == false:
			if (long == 1):
				if(hay_barco[equipo[fila_aleatoria][columna_aleatoria]] == false):
					var id = obtener_id_unico()
					hay_barco[equipo[fila_aleatoria][columna_aleatoria]] = true
					if radar == true: equipo[fila_aleatoria][columna_aleatoria].frame = 3
					id_barco[equipo[fila_aleatoria][columna_aleatoria]] = id
					#print(str(fila_aleatoria)+":"+str(columna_aleatoria)+":"+str(long))
					break
			# hemos encontrado un objetivo libre
			var direcciones = ["arriba","derecha"]
			var direccion = direcciones[randi() % direcciones.size()]
			match direccion:
				"arriba":
					if long > 3: continue
					elif (long == 3):
						var libres = true
						for i in range(1,4):
							if hay_barco[equipo[i][columna_aleatoria]] == true:
								libres = false
						if libres == false : continue
						else:
							var id = obtener_id_unico()
							for i in range(1,4):
								id_barco[equipo[i][columna_aleatoria]] = id
								hay_barco[equipo[i][columna_aleatoria]] = true
								if radar == true: equipo[i][columna_aleatoria].frame = 3
							#print(str(fila_aleatoria)+":"+str(columna_aleatoria)+":"+str(long))
							break
					elif (long == 2):
						if (fila_aleatoria == 1):
							if(hay_barco[equipo[1][columna_aleatoria]] == false && hay_barco[equipo[2][columna_aleatoria]] == false):
									var id = obtener_id_unico()
									hay_barco[equipo[1][columna_aleatoria]] = true
									hay_barco[equipo[2][columna_aleatoria]] = true
									if radar == true: equipo[2][columna_aleatoria].frame = 3
									if radar == true: equipo[1][columna_aleatoria].frame = 3
									id_barco[equipo[2][columna_aleatoria]] = id
									id_barco[equipo[1][columna_aleatoria]] = id
									#print(str(fila_aleatoria)+":"+str(columna_aleatoria)+":"+str(long))
									break
						if (fila_aleatoria == 3):
							if(hay_barco[equipo[1][columna_aleatoria]] == false && hay_barco[equipo[3][columna_aleatoria]] == false):
									var id = obtener_id_unico()
									hay_barco[equipo[1][columna_aleatoria]] = true
									hay_barco[equipo[3][columna_aleatoria]] = true
									if radar == true: equipo[3][columna_aleatoria].frame = 3
									if radar == true: equipo[1][columna_aleatoria].frame = 3
									id_barco[equipo[3][columna_aleatoria]] = id
									id_barco[equipo[1][columna_aleatoria]] = id
									#print(str(fila_aleatoria)+":"+str(columna_aleatoria)+":"+str(long))
									break
					
					else: continue
					
				"derecha":
					var num_izq = columna_aleatoria
					var libres = true
					if hay_barco[equipo[fila_aleatoria][columna_aleatoria]] == true:
						libres = false
					for i in range(long-1):
						if hay_barco[equipo[fila_aleatoria][derecha(num_izq)]] == true:
								libres = false
						num_izq = derecha(num_izq)
						
					if libres == false : continue
					else:
						var id = obtener_id_unico()
						num_izq = columna_aleatoria
						hay_barco[equipo[fila_aleatoria][columna_aleatoria]] = true
						if radar == true: equipo[fila_aleatoria][columna_aleatoria].frame = 3
						id_barco[equipo[fila_aleatoria][columna_aleatoria]] = id
						for i in range(long-1):
							hay_barco[equipo[fila_aleatoria][derecha(num_izq)]] = true
							if radar == true: equipo[fila_aleatoria][derecha(num_izq)].frame = 3
							id_barco[equipo[fila_aleatoria][derecha(num_izq)]] = id
							num_izq = derecha(num_izq)
							
						#print(str(fila_aleatoria)+":"+str(columna_aleatoria)+":derecha:"+str(long))
						break

func derecha(numero):
	if numero == 5:
		return 20
	var dch = find_index(sec_numeros,numero)
	return dch
func find_index(list,number):
	for i in range(list.size()):
		if list[i] == number:
			return list[i+1]
	return -1
func obtener_id_unico():
	id_unico = id_unico + 1
	return id_unico
func deep_duplicate(arr):
	var duplicate = []
	for i in arr:
		if typeof(i) == TYPE_ARRAY:
			duplicate.append(deep_duplicate(i))
		else:
			duplicate.append(i)
	return duplicate

func actualizar_marcadores():
	$Leyenda/Num_ronda.text = str(ronda_actual)
	$Leyenda/Num_equipo.text = str(jugador_actual)
	$Dardos/dardo1.text = dardos[1]
	$Dardos/dardo2.text = dardos[2]
	$Dardos/dardo3.text = dardos[3]
	$Leyenda/ObjetivosT1.text = str(impactos_T1)+"/"+str(total_objetivos)
	$Leyenda/ObjetivosT2.text = str(impactos_T2)+"/"+str(total_objetivos)
func empezar_partida():
	ronda_actual = 1
	equipo_actual = T1
	iniciar_ronda()

func iniciar_ronda():
	dardos[1] = "espera"
	dardos[2] = "espera"
	dardos[3] = "espera"
	actualizar_marcadores()
	guardar_frames(equipo_actual)
	ronda(equipo_actual)
	AUDIOS.playsound("J"+str(jugador_actual))

func ronda(equipo):
	$NEXT.disabled = true
	$Rewrite.disabled = true
	await GLOBAL.enviar_dardo
	dardos[1] = GLOBAL.ULTIMO_DARDO
	check_dardo(GLOBAL.ULTIMO_DARDO,equipo)
	actualizar_marcadores()
	if check_final(equipo) == true: return
	
	await GLOBAL.enviar_dardo
	dardos[2] = GLOBAL.ULTIMO_DARDO
	check_dardo(GLOBAL.ULTIMO_DARDO,equipo)
	actualizar_marcadores()
	if check_final(equipo) == true: return
	
	await GLOBAL.enviar_dardo
	dardos[3] = GLOBAL.ULTIMO_DARDO
	check_dardo(GLOBAL.ULTIMO_DARDO,equipo)
	actualizar_marcadores()
	if check_final(equipo) == true: return
	
	AUDIOS.playsound("NEXT_PLAYER")
	$NEXT.disabled = false
	$Rewrite.disabled = false
func check_dardo(texto,equipo):
	if texto == ("OUT"):
		AUDIOS.playsound("AGUA")
		return
	var partes = texto.split(":")
	if partes.size() == 2:
		var numero = int(partes[0].strip_edges().to_upper())
		if numero == 25: 
			AUDIOS.playsound("AGUA")
			return
		var letra = partes[1].strip_edges().to_upper()
		var tipo: int = 0
		match letra:
			"S": tipo = 1
			"D": tipo = 2
			"T": tipo = 3
		if equipo[tipo][numero].frame == 1: 
			AUDIOS.playsound("AGUA")
			return
		elif equipo[tipo][numero].frame == 2: 
			AUDIOS.playsound("AGUA")
			return
		elif equipo[tipo][numero].frame == 4: 
			AUDIOS.playsound("AGUA")
			return
		elif hay_barco[equipo[tipo][numero]] == false: 
			print("no hay barco")
			AUDIOS.playsound("AGUA")
			equipo[tipo][numero].frame = 4
		else:  #si ha impactado en uno nuevo
			equipo[tipo][numero].frame = 1
			if jugador_actual == 1: impactos_T1 +=1
			if jugador_actual == 2: impactos_T2 +=1
			var id = id_barco[equipo[tipo][numero]]
			var obj_tot = 0
			var impact_tot = 0
			for i in range(1, 4):
				for j in range(1, 21):
					if id_barco[equipo[i][j]] == id: 
						obj_tot += 1
						if equipo[i][j].frame == 1:
							impact_tot += 1
			if impact_tot == obj_tot:
				AUDIOS.playsound("HUNDIDO")
				for i in range(1, 4):
					for j in range(1, 21):
						if id_barco[equipo[i][j]] == id: 
							equipo[i][j].frame = 2
			else: AUDIOS.playsound("TOCADO")
							
					
						
	
func _on_next_pressed():
	if jugador_actual == 1:
		jugador_actual = 2
		equipo_actual = T2
	else:
		jugador_actual = 1
		equipo_actual = T1
		ronda_actual += 1
	iniciar_ronda()
func _on_out_pressed():
	GLOBAL.ULTIMO_DARDO = "OUT"
	GLOBAL.SONIDO_DARDO = "AGUA"
	GLOBAL.notificar_dardo_enviado()
func _on_rewrite_pressed():
	if jugador_actual == 1:
		cargar_frames(T1)
	else:
		cargar_frames(T2)
	iniciar_ronda()

func guardar_frames(equipo):
	for i in range(1, 4):
		for j in range(1, 21):
			frames_inicio_ronda[i][j] = equipo[i][j].frame
func cargar_frames(equipo):
	var cont: int = 0
	for i in range(1, 4):
		for j in range(1, 21):
			equipo[i][j].frame = frames_inicio_ronda[i][j]
			if (equipo[i][j].frame == 1 || equipo[i][j].frame ==2):
				cont +=1
	if (equipo == T1): impactos_T1 = cont
	else: impactos_T2 = cont
func check_final(equipo):
	var cont: int = 0
	for i in range(1, 4):
		for j in range(1, 21):
			if (equipo[i][j].frame == 1 || equipo[i][j].frame ==2):
				cont +=1
	if cont >= total_objetivos:
		GLOBAL.video(win,audio)
		return true


func _on_salir_pressed():
	get_tree().change_scene_to_file("res://Escenas/HundirLaFlota_MENU.tscn")
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


func _on_win_animation_finished():
		win.visible = false
		get_tree().change_scene_to_file("res://Escenas/HundirLaFlota_MENU.tscn")

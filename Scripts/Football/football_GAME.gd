extends Control

var lista_dorsales = GLOBAL.lista_dorsales
var escudo1 = GLOBAL.escudo1
var escudo2 = GLOBAL.escudo2
var camiseta1 = GLOBAL.camiseta1
var camiseta2 = GLOBAL.camiseta2
var color_local = GLOBAL.color_local
var color_visitante = GLOBAL.color_visitante
var jugadores1 = {}#lista con los sprites de cada jugador
var jugadores2 = {}
var info_jugadores1 = [2,2,2,2,2,2,2,2,2,2,2] #array de jugadores donde para cada uno 0=vacio 1=uno para pase 2=2para pase 3=3para pase 4=tiene el balon
var info_jugadores2 = [2,2,2,2,2,2,2,2,2,2,2]
var porteria1 = 0 #0=no se puede meter gol 1=una diana para gol 2=2dianas para gol
var porteria2 = 0
var marcas1 = {} #lista con los sprites de las marcas de cada jugador ( 0=balon 1=vacio 2=1marca 3=2marcas 4=3marcas)
var marcas2 = {}
var balon_equipo = 1 #que equipo tiene el balon
var balon_jugador = 6 #que jugador tiene el balon de ese equipo
var atacando : bool = true
var es_disparo : bool = false
var portero = [0]
var defensas = [1,2,3,4]
var mediocentros = [5,6,7]
var delanteros = [8,9,10]

var dardos = ["", "espera", "espera", "espera"]
var ronda_actual : int = 1
var equipo_actual: int = 1
var pts1 = 0
var pts2 = 0
var timer_on = false

var pts1_inicio_ronda = 0
var pts2_inicio_ronda = 0
var es_disapro_inicio_ronda : bool = false
var balon_equipo_incio_ronda = 1
var balon_jugador_inicio_ronda = 1

var lim_goles = GLOBAL.lim_goles
var lim_rondas = GLOBAL.lim_rondas

#videos
@onready var arbitro = $Videos/arbitro
@onready var parada = $Videos/parada
@onready var gol = $Videos/gol
@onready var tiro = $Videos/tiro
@onready var end = $Videos/end

@onready var audioarb = $Videos/arbitro/Audioarb
@onready var audiopar = $Videos/parada/Audiopar
@onready var audiogol = $Videos/gol/Audiogol
@onready var audiotir = $Videos/tiro/Audiotir
@onready var audioend = $Videos/end/Audioend


# Called when the node enters the scene tree for the first time.
func _ready():
	preparar_variables()
	preparar_pantalla()
	saque_de_centro(1)
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
func preparar_pantalla():
	$"jugadores/equipo1/1/numero".text = str(lista_dorsales[0])
	$"jugadores/equipo1/2/numero".text = str(lista_dorsales[1])
	$"jugadores/equipo1/3/numero".text = str(lista_dorsales[2])
	$"jugadores/equipo1/4/numero".text = str(lista_dorsales[3])
	$"jugadores/equipo1/5/numero".text = str(lista_dorsales[4])
	$"jugadores/equipo1/6/numero".text = str(lista_dorsales[5])
	$"jugadores/equipo1/7/numero".text = str(lista_dorsales[6])
	$"jugadores/equipo1/8/numero".text = str(lista_dorsales[7])
	$"jugadores/equipo1/9/numero".text = str(lista_dorsales[8])
	$"jugadores/equipo1/10/numero".text = str(lista_dorsales[9])
	$"jugadores/equipo1/11/numero".text = str(lista_dorsales[10])
	$"jugadores/equipo2/1/numero".text = str(lista_dorsales[0])
	$"jugadores/equipo2/2/numero".text = str(lista_dorsales[1])
	$"jugadores/equipo2/3/numero".text = str(lista_dorsales[2])
	$"jugadores/equipo2/4/numero".text = str(lista_dorsales[3])
	$"jugadores/equipo2/5/numero".text = str(lista_dorsales[4])
	$"jugadores/equipo2/6/numero".text = str(lista_dorsales[5])
	$"jugadores/equipo2/7/numero".text = str(lista_dorsales[6])
	$"jugadores/equipo2/8/numero".text = str(lista_dorsales[7])
	$"jugadores/equipo2/9/numero".text = str(lista_dorsales[8])
	$"jugadores/equipo2/10/numero".text = str(lista_dorsales[9])
	$"jugadores/equipo2/11/numero".text = str(lista_dorsales[10])
	
	$"jugadores/equipo1/1/numero".set("theme_override_colors/font_color",color_local)
	$"jugadores/equipo1/2/numero".set("theme_override_colors/font_color",color_local)
	$"jugadores/equipo1/3/numero".set("theme_override_colors/font_color",color_local)
	$"jugadores/equipo1/4/numero".set("theme_override_colors/font_color",color_local)
	$"jugadores/equipo1/5/numero".set("theme_override_colors/font_color",color_local)
	$"jugadores/equipo1/6/numero".set("theme_override_colors/font_color",color_local)
	$"jugadores/equipo1/7/numero".set("theme_override_colors/font_color",color_local)
	$"jugadores/equipo1/8/numero".set("theme_override_colors/font_color",color_local)
	$"jugadores/equipo1/9/numero".set("theme_override_colors/font_color",color_local)
	$"jugadores/equipo1/10/numero".set("theme_override_colors/font_color",color_local)
	$"jugadores/equipo1/11/numero".set("theme_override_colors/font_color",color_local)
	$"jugadores/equipo2/1/numero".set("theme_override_colors/font_color",color_visitante)
	$"jugadores/equipo2/2/numero".set("theme_override_colors/font_color",color_visitante)
	$"jugadores/equipo2/3/numero".set("theme_override_colors/font_color",color_visitante)
	$"jugadores/equipo2/4/numero".set("theme_override_colors/font_color",color_visitante)
	$"jugadores/equipo2/5/numero".set("theme_override_colors/font_color",color_visitante)
	$"jugadores/equipo2/6/numero".set("theme_override_colors/font_color",color_visitante)
	$"jugadores/equipo2/7/numero".set("theme_override_colors/font_color",color_visitante)
	$"jugadores/equipo2/8/numero".set("theme_override_colors/font_color",color_visitante)
	$"jugadores/equipo2/9/numero".set("theme_override_colors/font_color",color_visitante)
	$"jugadores/equipo2/10/numero".set("theme_override_colors/font_color",color_visitante)
	$"jugadores/equipo2/11/numero".set("theme_override_colors/font_color",color_visitante)
	
	$Marcador/esc1.frame = escudo1
	$Marcador/esc2.frame = escudo2
	
func preparar_variables():
	var equipo1 = $jugadores/equipo1
	var equipo2 = $jugadores/equipo2
	for i in range(11):
		var nodo = equipo1.get_node(str(i+1))
		var jugador = nodo.get_node("jugador")
		jugador.frame = camiseta1
		jugadores1[i] = jugador
		var marca = nodo.get_node("Marcas")
		marcas1[i] = marca
		
		nodo = equipo2.get_node(str(i+1))
		jugador = nodo.get_node("jugador")
		jugador.frame = camiseta2
		jugadores2[i] = jugador
		marca = nodo.get_node("Marcas")
		marcas2[i] = marca
		
		info_jugadores1[i] = int(0)
		info_jugadores2[i] = int(0)
		
	jugadores1[0].frame = escudo1-1 #ponemos la equipacion del portero
	jugadores2[0].frame = escudo2-1
	
func actualizar_pantalla():
	$Dardos/dardo1.text = dardos[1]
	$Dardos/dardo2.text = dardos[2]
	$Dardos/dardo3.text = dardos[3]
	$Marcador/pts1.text = str(pts1)
	$Marcador/pts2.text = str(pts2)
	$porteria1.frame = porteria1
	$porteria2.frame = porteria2
	$Ronda/numronda.text = str(ronda_actual)
	if equipo_actual == 1: $turno.frame = escudo1
	else: $turno.frame = escudo2
	if lim_rondas != 1000: $limites/rondas.text = str(lim_rondas)
	else: $limites/rondas.text = "-"
	if lim_goles != 1000: $limites/goles.text = str(lim_goles)
	else: $limites/goles.text = "-"
	for i in range(11):
		marcas1[i].frame = int(info_jugadores1[i])
		marcas2[i].frame = int(info_jugadores2[i])
func saque_de_centro(a):
	if a == 1: #saca equipo 1
		balon_equipo = 1
		balon_jugador = 6
	if a == 2: #saca equipo 1
		balon_equipo = 2
		balon_jugador = 6
	mover_balon()
func mover_balon():
	if equipo_actual == balon_equipo:
		campo_atacando()
		atacando = true
	else:
		campo_defendiendo()	
		atacando = false
	actualizar_pantalla()
func campo_atacando():
	porteria1=0
	porteria2=0 #dentro de los if lo reajustaremos
	if balon_equipo == 1:
		for i in range(11):
			info_jugadores2[i] = 0 # marcas vacias esta jugando el otro equipo y ademas tiene el balon
		if esta_en_lista(portero,balon_jugador):#si la tiene el portero
			info_jugadores1[0] = 4
			info_jugadores1[1] = 1
			info_jugadores1[2] = 1
			info_jugadores1[3] = 1
			info_jugadores1[4] = 1
			info_jugadores1[5] = 2
			info_jugadores1[6] = 2
			info_jugadores1[7] = 2
			info_jugadores1[8] = 3
			info_jugadores1[9] = 3
			info_jugadores1[10] = 3
		if esta_en_lista(defensas,balon_jugador):#si la tiene el portero
			info_jugadores1[0] = 1
			info_jugadores1[1] = 1
			info_jugadores1[2] = 1
			info_jugadores1[3] = 1
			info_jugadores1[4] = 1
			info_jugadores1[5] = 1
			info_jugadores1[6] = 1
			info_jugadores1[7] = 1
			info_jugadores1[8] = 2
			info_jugadores1[9] = 2
			info_jugadores1[10] = 2
		if esta_en_lista(mediocentros,balon_jugador):#si la tiene el portero
			info_jugadores1[0] = 2
			info_jugadores1[1] = 1
			info_jugadores1[2] = 1
			info_jugadores1[3] = 1
			info_jugadores1[4] = 1
			info_jugadores1[5] = 1
			info_jugadores1[6] = 1
			info_jugadores1[7] = 1
			info_jugadores1[8] = 1
			info_jugadores1[9] = 1
			info_jugadores1[10] = 1
			porteria2=2
		if esta_en_lista(delanteros,balon_jugador):#si la tiene el portero
			info_jugadores1[0] = 3
			info_jugadores1[1] = 2
			info_jugadores1[2] = 2
			info_jugadores1[3] = 2
			info_jugadores1[4] = 2
			info_jugadores1[5] = 1
			info_jugadores1[6] = 1
			info_jugadores1[7] = 1
			info_jugadores1[8] = 1
			info_jugadores1[9] = 1
			info_jugadores1[10] = 1
			porteria2=1
		info_jugadores1[balon_jugador]=4
	else:
		for i in range(11):
			info_jugadores1[i] = 0 # marcas vacias esta jugando el otro equipo y ademas tiene el balon
		if esta_en_lista(portero,balon_jugador):#si la tiene el portero
			info_jugadores2[0] = 4
			info_jugadores2[1] = 1
			info_jugadores2[2] = 1
			info_jugadores2[3] = 1
			info_jugadores2[4] = 1
			info_jugadores2[5] = 2
			info_jugadores2[6] = 2
			info_jugadores2[7] = 2
			info_jugadores2[8] = 3
			info_jugadores2[9] = 3
			info_jugadores2[10] = 3
		if esta_en_lista(defensas,balon_jugador):#si la tiene el portero
			info_jugadores2[0] = 1
			info_jugadores2[1] = 1
			info_jugadores2[2] = 1
			info_jugadores2[3] = 1
			info_jugadores2[4] = 1
			info_jugadores2[5] = 1
			info_jugadores2[6] = 1
			info_jugadores2[7] = 1
			info_jugadores2[8] = 2
			info_jugadores2[9] = 2
			info_jugadores2[10] = 2
		if esta_en_lista(mediocentros,balon_jugador):#si la tiene el portero
			info_jugadores2[0] = 2
			info_jugadores2[1] = 1
			info_jugadores2[2] = 1
			info_jugadores2[3] = 1
			info_jugadores2[4] = 1
			info_jugadores2[5] = 1
			info_jugadores2[6] = 1
			info_jugadores2[7] = 1
			info_jugadores2[8] = 1
			info_jugadores2[9] = 1
			info_jugadores2[10] = 1
			porteria1=2
		if esta_en_lista(delanteros,balon_jugador):#si la tiene el portero
			info_jugadores2[0] = 3
			info_jugadores2[1] = 2
			info_jugadores2[2] = 2
			info_jugadores2[3] = 2
			info_jugadores2[4] = 2
			info_jugadores2[5] = 1
			info_jugadores2[6] = 1
			info_jugadores2[7] = 1
			info_jugadores2[8] = 1
			info_jugadores2[9] = 1
			info_jugadores2[10] = 1
			porteria1=1
		info_jugadores2[balon_jugador]=4
func campo_defendiendo():
	porteria1 = 0
	porteria2 = 0
	if es_disparo == true:
		for i in range(11):
			info_jugadores1[i] = 0 
			info_jugadores2[i] = 0 
		if balon_equipo == 1:
			info_jugadores1[balon_jugador] = 4
			porteria1 = 0
			porteria2 = 1
		if balon_equipo == 2:
			info_jugadores2[balon_jugador] = 4
			porteria1 = 1
			porteria2 = 0
		return	
	if balon_equipo == 2:
		for i in range(11):
			info_jugadores1[i] = 0 #ele que defiende sin marcas, luego añadiremos quien puede quitarle el balon
			info_jugadores2[i] = 0 #los del otro equipo sin marcas
		info_jugadores2[balon_jugador] = 4 #menos el que tiene el balon
		#añadimos quien puede quitarle el balon
		if balon_jugador == 0: #si la tiene el portero
			info_jugadores1[10] = 1
			info_jugadores1[9] = 1
			info_jugadores1[8] = 1
			
		if balon_jugador == 1: #si la tiene los defensas
			info_jugadores1[8] = 1
		if balon_jugador == 2:
			info_jugadores1[8] = 1
			info_jugadores1[9] = 1
		if balon_jugador == 3:
			info_jugadores1[10] = 1
			info_jugadores1[9] = 1
		if balon_jugador == 4:
			info_jugadores1[10] = 1
			
		if balon_jugador == 5: info_jugadores1[5] = 1 #centrocampistas
		if balon_jugador == 6: info_jugadores1[6] = 1
		if balon_jugador == 7: info_jugadores1[7] = 1
		
		if balon_jugador == 8:
			info_jugadores1[1] = 1
			info_jugadores1[2] = 1
		if balon_jugador == 9:
			info_jugadores1[2] = 1
			info_jugadores1[3] = 1
		if balon_jugador == 10:
			info_jugadores1[3] = 1
			info_jugadores1[4] = 1
			
	else:
		for i in range(11):
			info_jugadores2[i] = 0 #ele que defiende sin marcas, luego añadiremos quien puede quitarle el balon
			info_jugadores1[i] = 0 #los del otro equipo sin marcas
		info_jugadores1[balon_jugador] = 4 #menos el que tiene el balon
		#añadimos quien puede quitarle el balon
		if balon_jugador == 0: #si la tiene el portero
			info_jugadores2[10] = 1
			info_jugadores2[9] = 1
			info_jugadores2[8] = 1
			
		if balon_jugador == 1: #si la tiene los defensas
			info_jugadores2[8] = 1
		if balon_jugador == 2:
			info_jugadores2[8] = 1
			info_jugadores2[9] = 1
		if balon_jugador == 3:
			info_jugadores2[10] = 1
			info_jugadores2[9] = 1
		if balon_jugador == 4:
			info_jugadores2[10] = 1
			
		if balon_jugador == 5: info_jugadores2[5] = 1 #centrocampistas
		if balon_jugador == 6: info_jugadores2[6] = 1
		if balon_jugador == 7: info_jugadores2[7] = 1
		
		if balon_jugador == 8:
			info_jugadores2[1] = 1
			info_jugadores2[2] = 1
		if balon_jugador == 9:
			info_jugadores2[2] = 1
			info_jugadores2[3] = 1
		if balon_jugador == 10:
			info_jugadores2[3] = 1
			info_jugadores2[4] = 1
		
		
func esta_en_lista(list,number):
	for i in range(list.size()):
		if list[i] == number:
			return true
	return false	


func empezar_partida():
	ronda_actual = 1
	equipo_actual = 1
	iniciar_ronda()

func iniciar_ronda():
	dardos[1] = "espera"
	dardos[2] = "espera"
	dardos[3] = "espera"
	pts1_inicio_ronda = pts1
	pts2_inicio_ronda = pts2
	es_disapro_inicio_ronda =es_disparo
	balon_equipo_incio_ronda = balon_equipo
	balon_jugador_inicio_ronda = balon_jugador
	mover_balon()
	actualizar_pantalla()
	ronda(equipo_actual)
	AUDIOS.playsound("J"+str(equipo_actual))

func ronda(equipo):
	$NEXT.disabled = true
	$Rewrite.disabled = true
	
	if es_disparo == true:
		ronda_con_parada(equipo)
		return
	
	for i in range(1, 4):
		await GLOBAL.enviar_dardo
		dardos[i] = GLOBAL.ULTIMO_DARDO
		var resultado = check_dardo(GLOBAL.ULTIMO_DARDO, equipo)
		AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
		if resultado != "falta" and resultado != "disparo":
			actualizar_pantalla()
		else:
			break
	
	actualizar_pantalla()
	$NEXT.disabled = false
	$Rewrite.disabled = false


func ronda_con_parada(equipo):
	await GLOBAL.enviar_dardo
	dardos[1] = GLOBAL.ULTIMO_DARDO
	check_parada(GLOBAL.ULTIMO_DARDO,equipo)
	AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
	actualizar_pantalla()
	
	for i in range(2, 4):
		await GLOBAL.enviar_dardo
		dardos[i] = GLOBAL.ULTIMO_DARDO
		AUDIOS.playsound(GLOBAL.SONIDO_DARDO)
		var resultado = check_dardo(GLOBAL.ULTIMO_DARDO, equipo)
		if resultado != "falta" and resultado != "disparo":
			actualizar_pantalla()
		else:
			break
	actualizar_pantalla()
	$NEXT.disabled = false
	$Rewrite.disabled = false
func check_dardo(texto,equipo):
	if texto == ("OUT"):
		return
	var partes = texto.split(":")
	if partes.size() == 2:
		var numero = int(partes[0].strip_edges().to_upper())
		var letra = partes[1].strip_edges().to_upper()
		var tipo: int = 0
		match letra:
			"S": tipo = 1
			"D": tipo = 2
			"T": tipo = 3
		if numero == 25:
			if equipo==1:
				if porteria2 != 0:
					porteria2 -= tipo
					if porteria2 <= 0:
						porteria2 = 1
						es_disparo = true
						mover_balon()
						video(tiro,audiotir)
						return "disparo"
			if equipo==2:
				if porteria1 != 0:
					porteria1 -= tipo
					if porteria1 <= 0:
						porteria1 = 1
						es_disparo = true
						mover_balon
						video(tiro,audiotir)
						return "disparo"
			return
		if esta_en_lista(lista_dorsales,numero) == false: return# si el numero no es un dorsal paramos
		var indice = find_index(lista_dorsales,numero) #vemos a que jugador corresponde ese dorsal
		if equipo == 1: #turno del equipo 1
			if atacando == false:#defendiendo
				if info_jugadores1[indice] == 4 : return#si es el que tiene la pelota paramos
				if info_jugadores1[indice] == 0: return#si no hay opcion de pase paramos
				if tipo != 1: 
					video(arbitro,audioarb)
					return "falta" #si ha sido doble o triple notificar falta
				if tipo == 1:
					balon_equipo = equipo #el balon cambia de equipo
					balon_jugador = indice #y lo tiene el jugador que ha robado
					mover_balon()
					return
			else: #atacando
				if info_jugadores1[indice] == 4 : return#si es el que tiene la pelota paramos
				if info_jugadores1[indice] == 0: return#si no hay opcion de pase paramos
				#si si que puede recibir pase:
				info_jugadores1[indice] -= tipo #le restamos el tipo de tiro que ha sido
				if info_jugadores1[indice] <= 0:#si has completado las marcas necesarias para hacer el pase
					balon_jugador= indice
					mover_balon()
					return
				else:
					return
		if equipo == 2: #turno del equipo 2
			if atacando == false:#defendiendo
				if info_jugadores2[indice] == 4 : return#si es el que tiene la pelota paramos
				if info_jugadores2[indice] == 0: return#si no hay opcion de pase paramos
				if tipo != 1: 
					video(arbitro,audioarb)
					return "falta" #si ha sido doble o triple notificar falta
				if tipo == 1:
					balon_equipo = equipo #el balon cambia de equipo
					balon_jugador = indice #y lo tiene el jugador que ha robado
					mover_balon()
					return
			else: #atacando
				if info_jugadores2[indice] == 4 : return#si es el que tiene la pelota paramos
				if info_jugadores2[indice] == 0: return#si no hay opcion de pase paramos
				#si si que puede recibir pase:
				info_jugadores2[indice] -= tipo #le restamos el tipo de tiro que ha sido
				if info_jugadores2[indice] <= 0:#si has completado las marcas necesarias para hacer el pase
					balon_jugador= indice
					mover_balon()
					return
				else:
					return
func check_parada(texto,equipo):
	es_disparo = false
	if texto == ("OUT"):
		return
	var partes = texto.split(":")
	if partes.size() == 2:
		var numero = int(partes[0].strip_edges().to_upper())
		if numero == 25:
			if equipo == 1:
				balon_equipo = 1
				balon_jugador = 0
			if equipo == 2:
				balon_equipo = 2
				balon_jugador = 0
			video(parada,audiopar)
		else:
			if equipo == 1:
				balon_equipo = 1
				balon_jugador = 6
				pts2 +=1
			if equipo == 2:
				balon_equipo = 2
				balon_jugador = 6
				pts1 +=1
			video(gol,audiogol)
		mover_balon()
		return
func find_index(list,number):
	for i in range(list.size()):
		if list[i] == number:
			return i
	return -1	

func video(sprite,audio):
	GLOBAL.video(sprite,audio)
	
func _on_next_pressed():
	if equipo_actual == 1:
		equipo_actual = 2
	else:
		equipo_actual = 1
		ronda_actual += 1
	if ronda_actual > lim_rondas:
		final_partido()
		return
	iniciar_ronda()
func _on_out_pressed():
	GLOBAL.ULTIMO_DARDO = "OUT"
	GLOBAL.notificar_dardo_enviado()
func _on_rewrite_pressed():
	pts1 = pts1_inicio_ronda
	pts2 = pts2_inicio_ronda
	es_disparo = es_disapro_inicio_ronda
	balon_equipo = balon_equipo_incio_ronda
	balon_jugador = balon_jugador_inicio_ronda
	iniciar_ronda()

func _on_salir_pressed():
	get_tree().change_scene_to_file("res://Escenas/football_MENU.tscn")


func _on_arbitro_animation_finished():
	arbitro.visible = false
func _on_parada_animation_finished():
	parada.visible = false
func _on_gol_animation_finished():
	gol.visible = false
	if ((pts1 == lim_goles)||(pts2 == lim_goles)):
		final_partido()
func final_partido():
	video(end,audioend)


func _on_tiro_animation_finished():
	tiro.visible = false
func _on_end_animation_finished():
	end.visible = false
	get_tree().change_scene_to_file("res://Escenas/football_MENU.tscn")

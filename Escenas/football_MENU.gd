extends Control

var clubes = [3,19,23]
var selecciones = [7,27,31]
var especiales = [11,15,35,39,43]
var colores = {}
var tipo1 = "CLUBES" #equipos, selecciones, especiales
var tipo2 = "SELECCIONES"
var rondas = 11
var goles = 3
var lim_goles_activo = true
var lim_rondas_activo = false
# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.escudo1 = 3
	GLOBAL.escudo2 = 7
	GLOBAL.camiseta1 = 0
	GLOBAL.camiseta2 = 4
	actualizar_pantalla()

func actualizar_pantalla():
	$SelectoresEquipo/Selector1/Tipo/Label.text = str(tipo1)
	$SelectoresEquipo/Selector1/Equipo/Sprite2D.frame = GLOBAL.escudo1
	$SelectoresEquipo/Selector1/Equipacion/Sprite2D.frame = GLOBAL.camiseta1
	$SelectoresEquipo/Selector2/Tipo/Label.text = str(tipo2)
	$SelectoresEquipo/Selector2/Equipo/Sprite2D.frame = GLOBAL.escudo2
	$SelectoresEquipo/Selector2/Equipacion/Sprite2D.frame = GLOBAL.camiseta2
	
	if lim_rondas_activo == true: $"Conf_fin_partida/Limite Rondas/HBoxContainer/Label".text = str(rondas)
	else: $"Conf_fin_partida/Limite Rondas/HBoxContainer/Label".text = "-"
	if lim_goles_activo == true: $"Conf_fin_partida/Limite Goles/HBoxContainer/Label".text = str(goles)
	else: $"Conf_fin_partida/Limite Goles/HBoxContainer/Label".text = "-"
func moverse_en_lista_adelante(lista,numero_actual,adelante):
	print("anterior = "+str(numero_actual))
	var index = find_index(lista,numero_actual)
	if adelante == true:
		if index != lista.size()-1:
			print("nuevo = "+str(lista[index+1]))
			return lista[index+1]
	else:
		if index > 0:
			print("nuevo = "+str(lista[index-1]))
			return lista[index-1]
	return numero_actual
func find_index(list,number):
	for i in range(list.size()):
		if list[i] == number:
			return i
	return -1	

func asignar_colores_dorsales():
	var blanco = Color(1,1,1)
	var negro = Color(0,0,0)
	var azul_oscuro = Color(0,0.05,1)#azul oscuro
	var amarillo = Color(1,1,0)
	var dorado = Color(0.77,0.64,0.03)
	var rojo = Color(1,0,0)
	var verde_oscuro = Color(0,0.62,0.05)
	colores[0] = azul_oscuro
	colores[1] = blanco
	colores[4] = amarillo
	colores[5] = amarillo
	colores[8] = blanco
	colores[9] = blanco
	colores[12] = blanco
	colores[13] = blanco
	colores[16] = blanco
	colores[17] = azul_oscuro
	colores[20] = negro
	colores[21] = blanco
	colores[24] = azul_oscuro
	colores[25] = blanco
	colores[28] = negro
	colores[29] = blanco
	colores[32] = blanco
	colores[33] = dorado
	colores[36] = verde_oscuro
	colores[37] = verde_oscuro
	colores[40] = negro
	colores[41] = negro
	GLOBAL.color_local = colores[GLOBAL.camiseta1]
	GLOBAL.color_visitante = colores[GLOBAL.camiseta2]
	
func _on_jugar_pressed():
	if lim_rondas_activo == true: GLOBAL.lim_rondas = rondas
	else: GLOBAL.lim_rondas = 1000
	
	if lim_goles_activo == true: GLOBAL.lim_goles = goles
	else: GLOBAL.lim_goles = 1000
	
	asignar_colores_dorsales()
	get_tree().change_scene_to_file("res://Escenas/football_GAME.tscn")
func _on_atras_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")

# ------------EQUIPO 1 -----------------
func _on__pressed(): #EQUIPO 1 TIPO
	if tipo1 == "CLUBES" : 
		tipo1 = "ESPECIALES"
		GLOBAL.escudo1 = especiales[0]
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
		print("de clubes a especiales")
	elif tipo1 == "ESPECIALES": 
		tipo1 = "SELECCIONES"
		GLOBAL.escudo1 = selecciones[0]
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
		print("de especiales a selecciones")
	elif tipo1=="SELECCIONES": 
		tipo1 = "CLUBES"
		GLOBAL.escudo1 = clubes[0]
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
		print("de selecciones a clubes")
	actualizar_pantalla()
func _on__pressed2():
	if tipo1 == "SELECCIONES" : 
		tipo1 = "ESPECIALES"
		GLOBAL.escudo1 = especiales[0]
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
		print("de selecciones a especiales")
	elif tipo1 == "CLUBES": 
		tipo1 = "SELECCIONES"
		GLOBAL.escudo1 = selecciones[0]
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
		print("de clubes a selecciones")
	elif tipo1=="ESPECIALES": 
		tipo1 = "CLUBES"
		GLOBAL.escudo1 = clubes[0]
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
		print("de especiales a clubes")
	actualizar_pantalla()

func _on__pressed3():#EQUIPO1 ESCUDO
	if tipo1 == "CLUBES":
		GLOBAL.escudo1 = moverse_en_lista_adelante(clubes,GLOBAL.escudo1,false)#true=adelante false=atras
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
	elif tipo1 == "SELECCIONES":
		GLOBAL.escudo1 = moverse_en_lista_adelante(selecciones,GLOBAL.escudo1,false)#true=adelante false=atras
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
	elif tipo1 == "ESPECIALES":
		GLOBAL.escudo1 = moverse_en_lista_adelante(especiales,GLOBAL.escudo1,false)#true=adelante false=atras
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
	actualizar_pantalla()
func _on__pressed4():
	if tipo1 == "CLUBES":
		GLOBAL.escudo1 = moverse_en_lista_adelante(clubes,GLOBAL.escudo1,true)#true=adelante false=atras
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
	elif tipo1 == "SELECCIONES":
		GLOBAL.escudo1 = moverse_en_lista_adelante(selecciones,GLOBAL.escudo1,true)#true=adelante false=atras
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
	elif tipo1 == "ESPECIALES":
		GLOBAL.escudo1 = moverse_en_lista_adelante(especiales,GLOBAL.escudo1,true)#true=adelante false=atras
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
	actualizar_pantalla()

func _on__pressed5():#EQUIPO1 CAMISETA
	if GLOBAL.camiseta1 == GLOBAL.escudo1-3:
		GLOBAL.camiseta1 = GLOBAL.escudo1-2
	else:
		GLOBAL.camiseta1 = GLOBAL.escudo1-3
	actualizar_pantalla()


# -----------EQUIPO 2 -----------------
func _on__pressed6(): #EQUIPO 2 TIPO
	if tipo2 == "CLUBES" : 
		tipo2 = "ESPECIALES"
		GLOBAL.escudo2 = especiales[0]
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
		print("de clubes a especiales")
	elif tipo2 == "ESPECIALES": 
		tipo2 = "SELECCIONES"
		GLOBAL.escudo2 = selecciones[0]
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
		print("de especiales a selecciones")
	elif tipo2=="SELECCIONES": 
		tipo2 = "CLUBES"
		GLOBAL.escudo2 = clubes[0]
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
		print("de selecciones a clubes")
	actualizar_pantalla()
func _on__pressed7():
	if tipo2 == "SELECCIONES" : 
		tipo2 = "ESPECIALES"
		GLOBAL.escudo2 = especiales[0]
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
		print("de selecciones a especiales")
	elif tipo2 == "CLUBES": 
		tipo2 = "SELECCIONES"
		GLOBAL.escudo2 = selecciones[0]
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
		print("de clubes a selecciones")
	elif tipo2=="ESPECIALES": 
		tipo2 = "CLUBES"
		GLOBAL.escudo2 = clubes[0]
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
		print("de especiales a clubes")
	actualizar_pantalla()

func _on__pressed8():#EQUIPO2 ESCUDO
	if tipo2 == "CLUBES":
		GLOBAL.escudo2 = moverse_en_lista_adelante(clubes,GLOBAL.escudo2,false)#true=adelante false=atras
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
	elif tipo2 == "SELECCIONES":
		GLOBAL.escudo2 = moverse_en_lista_adelante(selecciones,GLOBAL.escudo2,false)#true=adelante false=atras
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
	elif tipo2 == "ESPECIALES":
		GLOBAL.escudo2 = moverse_en_lista_adelante(especiales,GLOBAL.escudo2,false)#true=adelante false=atras
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
	actualizar_pantalla()
func _on__pressed9():
	if tipo2 == "CLUBES":
		GLOBAL.escudo2 = moverse_en_lista_adelante(clubes,GLOBAL.escudo2,true)#true=adelante false=atras
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
	elif tipo2 == "SELECCIONES":
		GLOBAL.escudo2 = moverse_en_lista_adelante(selecciones,GLOBAL.escudo2,true)#true=adelante false=atras
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
	elif tipo2 == "ESPECIALES":
		GLOBAL.escudo2 = moverse_en_lista_adelante(especiales,GLOBAL.escudo2,true)#true=adelante false=atras
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
	actualizar_pantalla()

func _on__pressed10():#EQUIPO2 CAMISETA
	if GLOBAL.camiseta2 == GLOBAL.escudo2-3:
		GLOBAL.camiseta2 = GLOBAL.escudo2-2
	else:
		GLOBAL.camiseta2 = GLOBAL.escudo2-3
	actualizar_pantalla()

#SELECTOR DE DORSALES
func _on_high_pressed():
	GLOBAL.lista_dorsales = [10,11,12,13,14,15,16,17,18,19,20]
func _on_clasico_pressed():
	GLOBAL.lista_dorsales = [1,2,3,4,5,6,7,8,9,10,11]
func _on_crazy_pressed():
	var numeros_aleatorios = generar_numeros_aleatorios(1, 20, 11)
	GLOBAL.lista_dorsales = numeros_aleatorios
func generar_numeros_aleatorios(minimo, maximo, cantidad):
	var numeros_generados = []
	# Genera números aleatorios sin repeticiones
	while numeros_generados.size() < cantidad:
		var numero = randi() % (maximo - minimo + 1) + minimo
		if not numeros_generados.has(numero):
			numeros_generados.append(numero)
	return numeros_generados

#CONFIGURACION DE LA PARTIDA (LIMITE RONDAS Y GOLES)
func _on_button_pressed_rondasmenos():
	if rondas != 1:
		rondas-=1
	actualizar_pantalla()
func _on_button_2_pressedrondasmas():
	if rondas != 999:
		rondas +=1
	actualizar_pantalla()
func _on_button_pressed_golesmenos():
	if goles !=1:
		goles -=1
	actualizar_pantalla()
func _on_button_2_pressed_golesmas():
	if goles!= 999:
		goles +=1
	actualizar_pantalla()
	
func _on_act_toggled_rondas(toggled_on):
	if toggled_on == true:
		lim_rondas_activo = true
	else:
		lim_rondas_activo = false
	actualizar_pantalla()
func _on_act_toggled(toggled_on):
	if toggled_on == true:
		lim_goles_activo = true
	else:
		lim_goles_activo = false
	actualizar_pantalla()

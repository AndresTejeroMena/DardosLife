extends Control
func _ready():
	GLOBAL.ESCENA_ACTUAL = "CONECTA_MENU"

func _on_normal_pressed():
	GLOBAL.objetivos_conecta4 = [0,20,19,18,17,16,15,14]
	GLOBAL.CONECTA_ALEATORIO = false
func _on_low_pressed():
	GLOBAL.objetivos_conecta4 = [0,1,2,3,4,5,6,7]
	GLOBAL.CONECTA_ALEATORIO = false
func _on_crazy_pressed():
	GLOBAL.CONECTA_ALEATORIO = true
	GLOBAL.objetivos_conecta4 = [0,0,0,0,0,0,0,0]
	var numeros_aleatorios = {}
	numeros_aleatorios[0] = int(0)
	numeros_aleatorios = generar_numeros_aleatorios(1, 20, 8)
	GLOBAL.objetivos_conecta4 = numeros_aleatorios

func generar_numeros_aleatorios(minimo, maximo, cantidad):
	var numeros_generados = []
	numeros_generados.append(0)
	# Genera números aleatorios sin repeticiones
	while numeros_generados.size() < cantidad:
		var numero = randi() % (maximo - minimo + 1) + minimo
		if not numeros_generados.has(numero):
			numeros_generados.append(numero)
	return numeros_generados


func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Escenas/Conecta4_GAME.tscn")
func _on_atras_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")

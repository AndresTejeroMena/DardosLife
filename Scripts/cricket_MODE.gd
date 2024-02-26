extends Control

func _ready():
	pass # Replace with function body.

func _on_jugadores_1_pressed():
	GLOBAL.NUMERO_JUGADORES = 1
func _on_jugadores_2_pressed():
	GLOBAL.NUMERO_JUGADORES = 2
func _on_jugadores_3_pressed():
	GLOBAL.NUMERO_JUGADORES = 3
func _on_jugadores_4_pressed():
	GLOBAL.NUMERO_JUGADORES = 4
func _on_jugadores_5_pressed():
	GLOBAL.NUMERO_JUGADORES = 5
func _on_jugadores_6_pressed():
	GLOBAL.NUMERO_JUGADORES = 6
func _on_jugadores_7_pressed():
	GLOBAL.NUMERO_JUGADORES = 7
func _on_jugadores_8_pressed():
	GLOBAL.NUMERO_JUGADORES = 8

func _on_normal_pressed():
	GLOBAL.objetivos_cricket = [20,19,18,17,16,15,25]
	GLOBAL.MODO_CRICKET = "Normal"
func _on_low_pressed():
	GLOBAL.objetivos_cricket = [1,2,3,4,5,6,25]
	GLOBAL.MODO_CRICKET = "Low"
func _on_crazy_pressed():
	var numeros_aleatorios = generar_numeros_aleatorios(1, 20, 6)
	numeros_aleatorios.append(25)
	GLOBAL.objetivos_cricket = numeros_aleatorios
	GLOBAL.MODO_CRICKET = "Crazy"
	print(numeros_aleatorios)

func generar_numeros_aleatorios(minimo, maximo, cantidad):
	var numeros_generados = []
	# Genera números aleatorios sin repeticiones
	while numeros_generados.size() < cantidad:
		var numero = randi() % (maximo - minimo + 1) + minimo
		if not numeros_generados.has(numero):
			numeros_generados.append(numero)
	return numeros_generados


func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Escenas/cricket_GAME.tscn")
func _on_atras_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")


func _on_cut_throat_toggled(pulsado):
	if pulsado == true:
		GLOBAL.cutthroat = true
	else:
		GLOBAL.cutthroat = false

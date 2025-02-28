extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.ESCENA_ACTUAL = "HUNDIR_MENU"
	GLOBAL.radar = true
	GLOBAL.portaviones = 0
	GLOBAL.acorazado = 0
	GLOBAL.crucero = 0
	GLOBAL.destructores = 0
	GLOBAL.submarinos = 0
	actualizar_pantalla()


func actualizar_pantalla():
	$BARCOS/Submarino/Ajustes/VBoxContainer/numero.text = str(GLOBAL.submarinos)
	$BARCOS/Destructor/Ajustes/VBoxContainer/numero.text = str(GLOBAL.destructores)
	$BARCOS/Crucero/Ajustes/VBoxContainer/numero.text = str(GLOBAL.crucero)
	$BARCOS/Acorazado/Ajustes/VBoxContainer/numero.text = str(GLOBAL.acorazado)
	$BARCOS/Portaviones/Ajustes/VBoxContainer/numero.text = str(GLOBAL.portaviones)


func _on__pressedSUB():
	if GLOBAL.submarinos != 0: 
		GLOBAL.submarinos -= 1
		actualizar_pantalla()


func _on__pressedSUBMAS():
	GLOBAL.submarinos += 1
	actualizar_pantalla()

func _on__pressedDES():
	if GLOBAL.destructores != 0: 
		GLOBAL.destructores -= 1
		actualizar_pantalla()


func _on__pressedDESMAS():
	GLOBAL.destructores += 1
	actualizar_pantalla()


func _on__pressedCRU():
	if GLOBAL.crucero != 0: 
		GLOBAL.crucero -= 1
		actualizar_pantalla()


func _on__pressedCRUMAS():
	GLOBAL.crucero += 1
	actualizar_pantalla()


func _on__pressedACO():
	if GLOBAL.acorazado != 0: 
		GLOBAL.acorazado -= 1
		actualizar_pantalla()


func _on__pressedACOMAS():
	GLOBAL.acorazado += 1
	actualizar_pantalla()


func _on__pressedPOR():
	if GLOBAL.portaviones != 0: 
		GLOBAL.portaviones -= 1
		actualizar_pantalla()


func _on__pressedPORMAS():
	GLOBAL.portaviones += 1
	actualizar_pantalla()


func _on_on_off_toggled(pulsado):
	if pulsado == true:
		GLOBAL.radar = true
	else:
		GLOBAL.radar = false


func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Escenas/HundirLaFlota_GAME.tscn")
func _on_atras_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")

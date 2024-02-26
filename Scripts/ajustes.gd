extends Control

var arduino_script
# Called when the node enters the scene tree for the first time.
func _ready():
	actualizar_pantalla()
	esperar_impactos()
	arduino_script = get_node("res://arduino.cs")

func actualizar_pantalla():
	$VBoxContainer/puerto/Label.text = GLOBAL.PUERTO
	$VBoxContainer/Tipo/lectura.text = GLOBAL.ULTIMO_DARDO
func esperar_impactos():
	while true:
		await GLOBAL.enviar_dardo
		actualizar_pantalla()


func _on__pressedmenos():
	var puerto_actual = GLOBAL.PUERTO
	var puerto_numero = puerto_actual[-1].to_int()
	if puerto_numero != null:
		puerto_numero = puerto_numero -1
		GLOBAL.PUERTO = "COM" + str(puerto_numero)
		cambiar_puerto_serie(GLOBAL.PUERTO)
		print("Nuevo puerto global:", GLOBAL.PUERTO)
	else:
		print("Error: No se puede extraer un número del puerto actual")
	actualizar_pantalla()
func _on__pressedmas():
	var puerto_actual = GLOBAL.PUERTO
	var puerto_numero = puerto_actual[-1].to_int()
	if puerto_numero != null:
		puerto_numero = puerto_numero +1
		GLOBAL.PUERTO = "COM" + str(puerto_numero)
		cambiar_puerto_serie(GLOBAL.PUERTO)
		print("Nuevo puerto global:", GLOBAL.PUERTO)
	else:
		print("Error: No se puede extraer un número del puerto actual")
	actualizar_pantalla()
func cambiar_puerto_serie(puerto):
	Arduino.StopReadingSerial()
	Arduino.StartReadingSerial(puerto)


func _on_atras_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")

extends Node

# Array que almacena los botones en el orden de navegación
var buttons: Array

# Índice del botón actualmente seleccionado
var selected_index: int = 0

func _ready():
	GLOBAL.ESCENA_ACTUAL = "MAIN_MENU"
	# Obtén los botones hijos del contenedor
	buttons = $VBoxContainer.get_children()
	
	# Inicialmente, enfoca el primer botón
	if buttons.size() > 0:
		buttons[selected_index].grab_focus()
		

func _on_salir_pressed():
	get_tree().quit()

func _on_x_01_pressed():
	get_tree().change_scene_to_file("res://Escenas/x01_MODE.tscn")

func _on_cricket_pressed():
	get_tree().change_scene_to_file("res://Escenas/cricket_MODE.tscn")

func _on_hundir_la_flota_pressed():
	get_tree().change_scene_to_file("res://Escenas/HundirLaFlota_MENU.tscn")

func _on_conecta_4_pressed():
	get_tree().change_scene_to_file("res://Escenas/Conecta4_MENU.tscn")


func _on_football_pressed():
	get_tree().change_scene_to_file("res://Escenas/football_MENU.tscn")


func _on_ajustes_pressed():
	get_tree().change_scene_to_file("res://Escenas/ajustes.tscn")


func _on_parchis_pressed():
	get_tree().change_scene_to_file("res://Escenas/ParchisMENU.tscn")


func _on_burma_pressed():
	get_tree().change_scene_to_file("res://Escenas/burmaMENU.tscn")

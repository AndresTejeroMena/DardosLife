extends Control

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

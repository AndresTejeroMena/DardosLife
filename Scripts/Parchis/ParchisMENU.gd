extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.ESCENA_ACTUAL = "PARCHIS_MENU"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on__pressed1():
	GLOBAL.NUMERO_JUGADORES = 1


func _on__pressed2():
	GLOBAL.NUMERO_JUGADORES = 2


func _on__pressed3():
	GLOBAL.NUMERO_JUGADORES = 3


func _on__pressed4():
	GLOBAL.NUMERO_JUGADORES = 4


func _on__pressed5():
	GLOBAL.NUMERO_JUGADORES = 5


func _on__pressed6():
	GLOBAL.NUMERO_JUGADORES = 6


func _on__pressed7():
	GLOBAL.NUMERO_JUGADORES = 7


func _on__pressed8():
	GLOBAL.NUMERO_JUGADORES = 8


func _on__pressed333():
	GLOBAL.parchis_objetivo = 333


func _on__pressed444():
	GLOBAL.parchis_objetivo = 444


func _on__pressed555():
	GLOBAL.parchis_objetivo = 555


func _on__pressed666():
	GLOBAL.parchis_objetivo = 666


func _on__pressed777():
	GLOBAL.parchis_objetivo = 777


func _on__pressed888():
	GLOBAL.parchis_objetivo = 888

func _on__pressed999():
	GLOBAL.parchis_objetivo = 999
	
func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Escenas/ParchisGAME.tscn")


func _on_atras_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")




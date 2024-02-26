extends Control

func _ready():
	await GLOBAL.enviar_dardo
	$"Leyenda Dardos/Dardo1".text = GLOBAL.ULTIMO_DARDO
	await GLOBAL.enviar_dardo
	$"Leyenda Dardos/Dardo2".text = GLOBAL.ULTIMO_DARDO
	await GLOBAL.enviar_dardo
	$"Leyenda Dardos/Dardo3".text = GLOBAL.ULTIMO_DARDO
	get_tree().change_scene_to_file("res://Escenas/x_01_GAME.tscn")

func marcar_dardo(i,tipo):
	GLOBAL.ULTIMO_DARDO = str(i) + ":" + tipo
	if i == 0:
		GLOBAL.ULTIMO_DARDO = "OUT"
	GLOBAL.notificar_dardo_enviado()
	print(GLOBAL.ULTIMO_DARDO)
	
	
func _on__pressed1s():
	marcar_dardo(1,"S")
func _on__pressed2s():
	marcar_dardo(2,"S")
func _on__pressed3s():
	marcar_dardo(3,"S")
func _on__pressed4s():
	marcar_dardo(4,"S")
func _on__pressed5s():
	marcar_dardo(5,"S")
func _on__pressed6s():
	marcar_dardo(6,"S")
func _on__pressed7s():
	marcar_dardo(7,"S")
func _on__pressed8s():
	marcar_dardo(8,"S")
func _on__pressed9s():
	marcar_dardo(9,"S")
func _on__pressed10s():
	marcar_dardo(10,"S")
func _on__pressed11s():
	marcar_dardo(11,"S")
func _on__pressed12s():
	marcar_dardo(12,"S")
func _on__pressed13s():
	marcar_dardo(13,"S")
func _on__pressed14s():
	marcar_dardo(14,"S")
func _on__pressed15s():
	marcar_dardo(15,"S")
func _on__pressed16s():
	marcar_dardo(16,"S")
func _on__pressed17s():
	marcar_dardo(17,"S")
func _on__pressed18s():
	marcar_dardo(18,"S")
func _on__pressed19s():
	marcar_dardo(19,"S")
func _on__pressed20s():
	marcar_dardo(20,"S")
	
	
func _on__pressed1d():
	marcar_dardo(1,"D")
func _on__pressed2d():
	marcar_dardo(2,"D")
func _on__pressed3d():
	marcar_dardo(3,"D")
func _on__pressed4d():
	marcar_dardo(4,"D")
func _on__pressed5d():
	marcar_dardo(5,"D")
func _on__pressed6d():
	marcar_dardo(6,"D")
func _on__pressed7d():
	marcar_dardo(7,"D")
func _on__pressed8d():
	marcar_dardo(8,"D")
func _on__pressed9d():
	marcar_dardo(9,"D")
func _on__pressed10d():
	marcar_dardo(10,"D")
func _on__pressed11d():
	marcar_dardo(11,"D")
func _on__pressed12d():
	marcar_dardo(12,"D")
func _on__pressed13d():
	marcar_dardo(13,"D")
func _on__pressed14d():
	marcar_dardo(14,"D")
func _on__pressed15d():
	marcar_dardo(15,"D")
func _on__pressed16d():
	marcar_dardo(16,"D")
func _on__pressed17d():
	marcar_dardo(17,"D")
func _on__pressed18d():
	marcar_dardo(18,"D")
func _on__pressed19d():
	marcar_dardo(19,"D")
func _on__pressed20d():
	marcar_dardo(20,"D")



func _on__pressed1t():
	marcar_dardo(1,"T")
func _on__pressed2t():
	marcar_dardo(2,"T")
func _on__pressed3t():
	marcar_dardo(3,"T")
func _on__pressed4t():
	marcar_dardo(4,"T")
func _on__pressed5t():
	marcar_dardo(5,"T")
func _on__pressed6t():
	marcar_dardo(6,"T")
func _on__pressed7t():
	marcar_dardo(7,"T")
func _on__pressed8t():
	marcar_dardo(8,"T")
func _on__pressed9t():
	marcar_dardo(9,"T")
func _on__pressed10t():
	marcar_dardo(10,"T")
func _on__pressed11t():
	marcar_dardo(11,"T")
func _on__pressed12t():
	marcar_dardo(12,"T")
func _on__pressed13t():
	marcar_dardo(13,"T")
func _on__pressed14t():
	marcar_dardo(14,"T")
func _on__pressed15t():
	marcar_dardo(15,"T")
func _on__pressed16t():
	marcar_dardo(16,"T")
func _on__pressed17t():
	marcar_dardo(17,"T")
func _on__pressed18t():
	marcar_dardo(18,"T")
func _on__pressed19t():
	marcar_dardo(19,"T")
func _on__pressed20t():
	marcar_dardo(20,"T")


func _on_out_pressed():
	marcar_dardo(00,"S")

func _on_bull_pressed():
	marcar_dardo(25,"S")

func _on_double_bull_pressed():
	marcar_dardo(25,"D")

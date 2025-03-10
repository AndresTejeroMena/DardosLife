extends Node

var sound = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	sound["S1"] = preload("res://audio/optimus/S1.ogg")
	sound["S2"] = preload("res://audio/optimus/S2.ogg")
	sound["S3"] = preload("res://audio/optimus/S3.ogg")
	sound["S4"] = preload("res://audio/optimus/S4.ogg")
	sound["S5"] = preload("res://audio/optimus/S5.ogg")
	sound["S6"] = preload("res://audio/optimus/S6.ogg")
	sound["S7"] = preload("res://audio/optimus/S7.ogg")
	sound["S8"] = preload("res://audio/optimus/S8.ogg")
	sound["S9"] = preload("res://audio/optimus/S9.ogg")
	sound["S10"] = preload("res://audio/optimus/S10.ogg")
	sound["S11"] = preload("res://audio/optimus/S11.ogg")
	sound["S12"] = preload("res://audio/optimus/S12.ogg")
	sound["S13"] = preload("res://audio/optimus/S13.ogg")
	sound["S14"] = preload("res://audio/optimus/S14.ogg")
	sound["S15"] = preload("res://audio/optimus/S15.ogg")
	sound["S16"] = preload("res://audio/optimus/S16.ogg")
	sound["S17"] = preload("res://audio/optimus/S17.ogg")
	sound["S18"] = preload("res://audio/optimus/S18.ogg")
	sound["S19"] = preload("res://audio/optimus/S19.ogg")
	sound["S20"] = preload("res://audio/optimus/S20.ogg")
	
	sound["D1"] = preload("res://audio/optimus/D1.ogg")
	sound["D2"] = preload("res://audio/optimus/D2.ogg")
	sound["D3"] = preload("res://audio/optimus/D3.ogg")
	sound["D4"] = preload("res://audio/optimus/D4.ogg")
	sound["D5"] = preload("res://audio/optimus/D5.ogg")
	sound["D6"] = preload("res://audio/optimus/D6.ogg")
	sound["D7"] = preload("res://audio/optimus/D7.ogg")
	sound["D8"] = preload("res://audio/optimus/D8.ogg")
	sound["D9"] = preload("res://audio/optimus/D9.ogg")
	sound["D10"] = preload("res://audio/optimus/D10.ogg")
	sound["D11"] = preload("res://audio/optimus/D11.ogg")
	sound["D12"] = preload("res://audio/optimus/D12.ogg")
	sound["D13"] = preload("res://audio/optimus/D13.ogg")
	sound["D14"] = preload("res://audio/optimus/D14.ogg")
	sound["D15"] = preload("res://audio/optimus/D15.ogg")
	sound["D16"] = preload("res://audio/optimus/D16.ogg")
	sound["D17"] = preload("res://audio/optimus/D17.ogg")
	sound["D18"] = preload("res://audio/optimus/D18.ogg")
	sound["D19"] = preload("res://audio/optimus/D19.ogg")
	sound["D20"] = preload("res://audio/optimus/D20.ogg")
	
	sound["T1"] = preload("res://audio/optimus/T1.ogg")
	sound["T2"] = preload("res://audio/optimus/T2.ogg")
	sound["T3"] = preload("res://audio/optimus/T3.ogg")
	sound["T4"] = preload("res://audio/optimus/T4.ogg")
	sound["T5"] = preload("res://audio/optimus/T5.ogg")
	sound["T6"] = preload("res://audio/optimus/T6.ogg")
	sound["T7"] = preload("res://audio/optimus/T7.ogg")
	sound["T8"] = preload("res://audio/optimus/T8.ogg")
	sound["T9"] = preload("res://audio/optimus/T9.ogg")
	sound["T10"] = preload("res://audio/optimus/T10.ogg")
	sound["T11"] = preload("res://audio/optimus/T11.ogg")
	sound["T12"] = preload("res://audio/optimus/T12.ogg")
	sound["T13"] = preload("res://audio/optimus/T13.ogg")
	sound["T14"] = preload("res://audio/optimus/T14.ogg")
	sound["T15"] = preload("res://audio/optimus/T15.ogg")
	sound["T16"] = preload("res://audio/optimus/T16.ogg")
	sound["T17"] = preload("res://audio/optimus/T17.ogg")
	sound["T18"] = preload("res://audio/optimus/T18.ogg")
	sound["T19"] = preload("res://audio/optimus/T19.ogg")
	sound["T20"] = preload("res://audio/optimus/T20.ogg")

	sound["S25"] = preload("res://audio/optimus/S25.ogg")
	sound["D25"] = preload("res://audio/optimus/D25.ogg")
	
	sound["J1"] = preload("res://audio/optimus/J1.ogg")
	sound["J2"] = preload("res://audio/optimus/J2.ogg")
	sound["J3"] = preload("res://audio/optimus/J3.ogg")
	sound["J4"] = preload("res://audio/optimus/J4.ogg")
	sound["J5"] = preload("res://audio/optimus/J5.ogg")
	sound["J6"] = preload("res://audio/optimus/J6.ogg")
	sound["J7"] = preload("res://audio/optimus/J7.ogg")
	sound["J8"] = preload("res://audio/optimus/J8.ogg")
	
	sound["OUT"] = preload("res://audio/optimus/OUT.ogg")
	sound["NEXT_PLAYER"] = preload("res://audio/optimus/NEXT_PLAYER.ogg")
	sound["CORRECTO"] = preload("res://audio/correcto.ogg")
	sound["FALLO_BOB"] = preload("res://audio/fail_bobesponja.ogg")
	
	sound["PASE"] = preload("res://audio/optimus/PASE.ogg")
	
	sound["AGUA"] = preload("res://audio/optimus/AGUA.ogg")
	sound["TOCADO"] = preload("res://audio/optimus/TOCADO.ogg")
	sound["HUNDIDO"] = preload("res://audio/optimus/HUNDIDO.ogg")

func playsound(text):
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = sound[text]
	add_child(audio_player)
	audio_player.play()

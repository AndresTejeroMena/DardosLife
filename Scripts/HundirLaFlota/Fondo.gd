extends AnimatedSprite2D
@onready var fondo = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	fondo.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

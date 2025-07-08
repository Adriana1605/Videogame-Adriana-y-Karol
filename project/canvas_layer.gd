extends CanvasLayer

@onready var contador_monedas: Label = $ContadorMonedas

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var contador = get_node("%Contador")
	

func _on_puntuacion_actualizada(puntuacion_actual: int) -> void:
	contador_monedas.text = str(puntuacion_actual)

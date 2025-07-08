extends AnimatableBody2D
enum TipoPlataforma {FIJA, OSCILATORIA, FRAGIL, REBOTE,PICOS}
@export var tipo: TipoPlataforma = TipoPlataforma.FIJA;
@export var fuerza_rebote := 2.0

func _ready():
	actualizar_plataforma()

func actualizar_plataforma():
	match tipo:
		TipoPlataforma.FIJA:
			$Sprite2D.modulate = Color.GREEN
		TipoPlataforma.OSCILATORIA:
			$Sprite2D.modulate = Color.BLUE
			oscilar()
		TipoPlataforma.FRAGIL:
			$Sprite2D.modulate = Color.RED
		TipoPlataforma.REBOTE:
			$Sprite2D.modulate = Color.AQUA
		TipoPlataforma.PICOS:
			$Sprite2D.modulate = Color.PURPLE


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		
		match tipo:

			TipoPlataforma.FRAGIL:
				await get_tree().create_timer(0.5).timeout
				queue_free()
			TipoPlataforma.PICOS:
				get_tree().reload_current_scene()
			TipoPlataforma.REBOTE:
				if body.has_method("puede_rebotar"):
					body.puede_rebotar(fuerza_rebote)
				else:
					body.velocity.y = body.brinco * fuerza_rebote
	pass # Replace with function body.

func oscilar():
	var tween = create_tween()
	tween.tween_property(self,"position:x",position.x + 100,2)
	tween.tween_property(self,"position:x",position.x - 100,2)
	tween.set_loops()
	
func picos():
	get_tree().reload_current_scene()
	
	

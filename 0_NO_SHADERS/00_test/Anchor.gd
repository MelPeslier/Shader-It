extends Node2D

@export var angle: float = 75
@export var delay: float = 0.0

func _ready() -> void:
	await get_tree().create_timer(delay).timeout
	
	var tween: Tween = get_tree().create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# 90 deg = -PI/2.0 rad
	tween.tween_property(self, "rotation", deg_to_rad(angle) , 1.5)
	tween.tween_property(self, "rotation", deg_to_rad(-angle), 1.5)

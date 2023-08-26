extends Area2D


@export var speed : float = 50.0
@export var direction : Vector2
@export var is_friendly : bool


@onready var main_scene = get_tree().current_scene
@onready var trail_effect_scene : PackedScene = preload("res://effects/trail_effect.tscn")


func _ready():
	spawn_trail_effect()


func _physics_process(delta):
	position += direction * speed * delta


func _on_screen_exited():
	queue_free()


func spawn_trail_effect():
	var trail_effect = trail_effect_scene.instantiate()
	
	trail_effect.direction = direction
	trail_effect.speed = speed
	trail_effect.global_position = global_position
	
	if is_friendly:
		trail_effect.default_color = Color(1, 1, 1, 1)
	else:
		trail_effect.default_color = Color(1, 0, 0, 1)
	
	main_scene.add_child(trail_effect)

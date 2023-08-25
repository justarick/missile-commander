extends Area2D


@export var speed : float = 50.0
@export var direction : Vector2


@onready var main_scene = get_tree().current_scene
@onready var trail_effect_scene : PackedScene = preload("res://effects/trail_effect.tscn")


func _ready():
	spawn_trail_effect()


func _physics_process(delta):
	position += direction * speed * delta


func _on_screen_exited():
	direction = Vector2.ZERO
	queue_free()


func spawn_trail_effect():
	print("Missile ")
	print(global_position)
	var trail_effect = trail_effect_scene.instantiate()
	main_scene.add_child(trail_effect)
	trail_effect.direction = direction
	trail_effect.speed = speed
	trail_effect.global_position = global_position

extends Node2D


@onready var main_scene : Node2D = get_tree().current_scene
@onready var screen_size : Vector2 = get_viewport_rect().size

@onready var marker_position : Vector2 = $Marker.global_position

@onready var missile_scene : PackedScene = preload("res://prefabs/missile.tscn")


func _ready(): pass


func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		spawn_missile(true)


func _on_hostile_missile_countdown_timeout():
	spawn_missile(false)


func spawn_missile(is_friendly : bool) -> void:
	var missile : Area2D = missile_scene.instantiate()
	
	missile.is_friendly = is_friendly
	missile.position = configure_missile_position(missile.is_friendly)
	missile.direction = configure_missile_direction(missile.is_friendly, missile.position)
	
	main_scene.add_child(missile)


func configure_missile_position(is_friendly : bool) -> Vector2:
	var missile_position : Vector2
	
	if is_friendly:
		missile_position = marker_position
	else:
		var random : RandomNumberGenerator = RandomNumberGenerator.new()
		missile_position = Vector2(random.randf() * screen_size.x, 0.0)
	
	return missile_position


func configure_missile_direction(is_friendly : bool, missile_position) -> Vector2:
	var missile_direction : Vector2
	
	if is_friendly:
		missile_direction = get_global_mouse_position() - marker_position
	else:
		var random : RandomNumberGenerator = RandomNumberGenerator.new()
		missile_direction.x = random.randf_range(-missile_position.x, screen_size.x - missile_position.x)
		missile_direction.y = screen_size.y
	
	missile_direction = missile_direction.normalized()
	
	return missile_direction

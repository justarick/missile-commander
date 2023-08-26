extends Node2D


@onready var main_scene : Node2D = get_tree().current_scene
@onready var missile_scene : PackedScene = preload("res://prefabs/missile.tscn")
@onready var friendly_missile_img : CompressedTexture2D = preload("res://assets/images/missile.png")
@onready var hostile_missile_img : CompressedTexture2D = preload("res://assets/images/enemy_missile.png")
@onready var marker_position : Vector2 = $Marker.global_position
@onready var screen_size : Vector2 = get_viewport_rect().size


func _ready(): pass


func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		spawn_friendly_missile()


func _on_hostile_missile_countdown_timeout():
	spawn_enemy_missile()


func spawn_friendly_missile():
	var missile : Area2D = missile_scene.instantiate()
	var spawn_point : Vector2 = marker_position
	var direction : Vector2 = get_global_mouse_position() - marker_position
	
	direction = direction.normalized()
	
	missile.global_position = spawn_point
	missile.direction = direction
	missile.is_friendly = true
	
	main_scene.add_child(missile)


func spawn_enemy_missile():
	var random : RandomNumberGenerator = RandomNumberGenerator.new()

	var missile : Area2D = missile_scene.instantiate()
	var spawn_point : Vector2 = Vector2(random.randf() * get_viewport_rect().size.x, 0.0)
	var direction : Vector2
	
	direction.x = random.randf_range(-spawn_point.x, screen_size.x - spawn_point.x)
	direction.y = screen_size.y
	direction = direction.normalized()
	
	missile.global_position = spawn_point
	missile.direction = direction
	missile.is_friendly = false
	
	main_scene.add_child(missile)

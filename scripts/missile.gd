extends Area2D


@export var is_friendly : bool
@export var speed : float = 50.0
@export var direction : Vector2


@onready var main_scene = get_tree().current_scene

@onready var trail = $TrailEffect


func _ready():
	configure_trail()


func _physics_process(delta):
	move(delta)
	update_trail()


func _on_screen_exited():
	queue_free()


func move(delta):
	position += direction * speed * delta


func update_trail():
	trail.add_point(position)


func configure_trail():
	if is_friendly:
		trail.default_color = Color.WHITE
	else:
		trail.default_color = Color.RED

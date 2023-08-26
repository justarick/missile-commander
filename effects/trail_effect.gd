extends Line2D


@export var max_points : int = 500
@export var speed : float
@export var direction : Vector2


@onready var point_position : Vector2 = Vector2.ZERO
@onready var is_on_screen : bool = true


func _ready(): pass


func _physics_process(delta):
	if is_on_screen:
		position += direction * speed * delta
		if get_point_count() < max_points + 1:
			point_position -= direction * speed * delta
			add_point(point_position)
	else:
		remove_point(get_point_count() - 1)
		if get_point_count() == 0:
			queue_free()


func _on_screen_exited():
	is_on_screen = false

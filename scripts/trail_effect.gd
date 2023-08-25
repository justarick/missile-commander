extends Line2D


@export var max_points : int = 500
@export var direction : Vector2
@export var speed : float


@onready var curve : Curve2D = Curve2D.new()


func _ready():
	print(position)


func _physics_process(delta):
	position = position + direction * speed * delta
	add_point(position)

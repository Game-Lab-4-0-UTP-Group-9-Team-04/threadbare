extends CharacterBody2D

@export var velocidad = 600
@export var daño = 3
var direccion = Vector2.ZERO

@onready var detector = $detector
@onready var detector_col = $detector/CollisionShape2D
@onready var colision = $CollisionShape2D

func _ready():
	detector.connect("body_entered", Callable(self, "_on_body_entered"))
	colision.disabled = true
	detector_col.disabled = true
	await get_tree().create_timer(0.1).timeout
	colision.disabled = false
	detector_col.disabled = false

func _physics_process(delta):
	if direccion != Vector2.ZERO:
		velocity = direccion.normalized() * velocidad
		move_and_slide()

	if is_on_wall():
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemigos") and body.has_method("recibir_daño"):
		body.recibir_daño(daño)
		queue_free()

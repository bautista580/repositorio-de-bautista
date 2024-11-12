extends CharacterBody2D

@export var mov_speed = 200
@onready var animated_sprite = $AnimatedSprite

#Todo está en el video q te pasé, menos el movimiento de y, hice lo mejor q pude sin poder hacer un debug visual 👍

var isFacingRight = true
var isMovingY = false
var isMovingUp = false

func checkMovingY():
	if velocity.y != 0:
		isMovingY = true
		isMovingUp = velocity.y < 0  # Actualiza `isMovingUp` para reflejar si va hacia arriba
	else:
		isMovingY = false
		isMovingUp = false  # Resetea `isMovingUp` cuando no se mueve en Y

func horizontalMovement():
	var input_axis = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_axis * mov_speed
	if velocity.x > 0:
		print("Moviendo a la derecha")
	elif velocity.x < 0:
		print("Moviendo a la izquierda")

func flip_x():
	if (isFacingRight and velocity.x < 0) or (not isFacingRight and velocity.x > 0):
		scale.x *= -1
		isFacingRight = not isFacingRight

func verticalMovement():
	var input_axis = Input.get_axis("ui_up", "ui_down")
	velocity.y = input_axis * mov_speed
	if velocity.y < 0:
		print("Moviendo hacia arriba")
	elif velocity.y > 0:
		print("Moviendo hacia abajo")

func flip_y():
	if isMovingY:
		if isMovingUp:
			scale.y = 1  # Escala normal al moverse hacia arriba
		else:
			scale.y = -1  # Invierte al moverse hacia abajo

func update_animation():
	if velocity.length() == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")

func _physics_process(delta):
	checkMovingY()
	horizontalMovement()
	verticalMovement()
	flip_x()
	flip_y()
	update_animation()
	
	move_and_slide()

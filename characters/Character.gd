class_name Character
extends KinematicBody2D

const FRICTION: float = 0.15

export(int) var acceleration: int = 40
export(int) var max_speed: int = 100

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

var move_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)


func move() -> void:
	move_direction = move_direction.normalized()
	velocity += move_direction * acceleration
	velocity = velocity.clamped(max_speed)

class_name Bow
extends Position2D



const BULLET_VELOCITY = 550
const Bullet = preload("res://src/Objects/Arrow.tscn")

onready var timer = $CooldownAttack


func shoot(direction = 1, height = 0):
	
	if not timer.is_stopped():
		return false
	var bullet = Bullet.instance()
	bullet.modulate = self.get_parent().get_parent().ARROW_COLOR
	bullet.global_position = global_position
	bullet.linear_velocity = Vector2(direction * BULLET_VELOCITY, height)

	bullet.set_as_toplevel(true)
	add_child(bullet)
	return true

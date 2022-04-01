extends Node2D

export var move_speed:float

var target:Vector2

onready var _body:KinematicBody2D = find_node("KinematicBody2D")

func _physics_process(delta):
  if target:
    var _direction_vector:Vector2 = global_position.direction_to(target)
    
    _body.move_and_slide(_direction_vector.normalized() * move_speed)

extends Node2D

export var move_speed:float

var move_target:Vector2

onready var _body:KinematicBody2D = find_node("KinematicBody2D")

func set_move_target(new_target:Vector2) -> void:
  move_target = new_target

func _physics_process(delta):
  if move_target:
    var _direction_vector:Vector2 = global_position.direction_to(move_target)
    
    _body.move_and_slide(_direction_vector.normalized() * move_speed)
  
  global_position = _body.global_position

extends KinematicBody2D

export var move_speed:float

var move_target:Vector2

var _distance_frames:Array = []
var _moving:bool

func set_move_target(new_target:Vector2) -> void:
  move_target = new_target
  _moving = true
  _distance_frames = []

func _physics_process(delta):
  if _moving:
    var _direction_vector:Vector2 = global_position.direction_to(move_target)

    move_and_slide(_direction_vector * move_speed)

    _distance_frames.append(global_position)
    if _distance_frames.size() > 64:
      _distance_frames.pop_front()

    var _total_distance:float = 0
    for i in range(1, _distance_frames.size()):
      _total_distance += _distance_frames[i].distance_to(_distance_frames[i - 1])

    if _distance_frames.size() >= 16 && _total_distance / _distance_frames.size() < 1:
      _moving = false

    if global_position.distance_to(move_target) <= move_speed * delta:
      _moving = false

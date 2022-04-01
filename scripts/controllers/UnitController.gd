extends Node2D

var _drawing_selection:bool = false
var _drawing_selection_start:Vector2

func _draw():
  if _drawing_selection:
    var _size:Vector2 = get_global_mouse_position() - _drawing_selection_start
    draw_rect(Rect2(_drawing_selection_start, _size), Color.green, false)


func _on_end_drawing_selection() -> void:
  var _selection_rect:Rect2 = Rect2(_drawing_selection_start, get_global_mouse_position() - _drawing_selection_start)
  var _units:Array = get_tree().get_nodes_in_group("units")
  var _selected_units:Array = []

  for _unit in _units:
    if _selection_rect.has_point(_unit.global_position):
      _selected_units.append(_unit)

  _drawing_selection = false
  Store.set_state("unit_selection", _selected_units)
  print("drawing ended")
  print(Store.state.unit_selection)

func _unhandled_input(event:InputEvent):
  if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
    if event.is_pressed():
      print("drawing started")
      _drawing_selection = true
      _drawing_selection_start = get_global_mouse_position()
    else:
      _on_end_drawing_selection()

  if event is InputEventMouseButton && event.button_index == BUTTON_RIGHT:
    if Store.state.unit_selection.size() && !event.is_pressed():
      for _unit in Store.state.unit_selection:
        _unit.set_move_target(get_global_mouse_position())
        print("issuing move order")

func _process(delta):
  update()

extends GridContainer

signal photo_selection_changed(photo, selection)
signal photo_mark_changed(photo, mark)

const PhotoFrameScene = preload("res://Scene/PhotoFrame.tscn")

const pattern = {
  0: [1, 1],
  1: [1, 1],
  2: [2, 1],
  3: [2, 2],
  4: [2, 2],
  5: [3, 2],
  6: [3, 2],
  7: [4, 2],
  8: [4, 2],
  9: [3, 3],
  10: [4, 3],
  11: [4, 3],
  12: [4, 3]
}

func clear_photos():
  for item in get_children():
    item.queue_free()
    
func update_photos(photos):
  clear_photos()
  
  var column_num = 1
  var row_num = 1
  var photos_count = photos.size()
  
  if photos_count in pattern:
    column_num = pattern[photos_count][0]
    row_num = pattern[photos_count][1]
  else:
    column_num = 4
    row_num = 3
    while column_num < 100 && row_num <100:
      if row_num < column_num:
        row_num += 1
      else:
        column_num += 1
        
      if column_num * row_num >= photos_count:
        break
  
  columns = column_num 
  var w = int((OS.window_size.x - 200) / columns)
  var h = int(OS.window_size.y / row_num)
  
  for photo in photos:
    var photo_frame = PhotoFrameScene.instance()
    photo_frame.init(w, h, photo)
    add_child(photo_frame)

func get_hovering_frame(pos):
  for frame in get_children():
    var g_pos = frame.rect_position
    if pos.x >= g_pos.x and pos.y >= g_pos.y and pos.x <= g_pos.x + frame.rect_size.x and pos.y <= g_pos.y + frame.rect_size.y:
      return frame
      
  return null
  
var prev_mouse_pos = Vector2.ZERO
func _on_Grid_gui_input(event):
  var with_ctrl = event.control
  var with_alt = event.alt
  var with_shift = event.shift
  
  var hovering_frame = get_hovering_frame(event.position)
  
  var button_index = 0
  var pressed = false
  if event is InputEventMouseButton:
    button_index = event.button_index
    pressed = event.pressed
  
  if button_index == BUTTON_LEFT:
    if pressed:
      if event.doubleclick:
        for frame in get_children():
          if with_shift and hovering_frame != frame:
            continue
          
          frame.reset_size()
      elif with_alt and hovering_frame != null:
        hovering_frame.photo.toggle_mark()
      elif with_ctrl and hovering_frame != null:
        hovering_frame.photo.toggle_selection()
      else:
        prev_mouse_pos = event.position
    else:
      prev_mouse_pos = Vector2.ZERO
      
  elif (button_index == BUTTON_WHEEL_UP or button_index == BUTTON_WHEEL_DOWN) and pressed:
    var is_up = button_index == BUTTON_WHEEL_UP
    for frame in get_children():
      if with_alt:
        frame.gamma += 0.1 if is_up else -0.1
        frame.update_shader()
        continue
        
      if with_ctrl:
        frame.EV += 0.1 if is_up else -0.1
        frame.update_shader()
        continue
        
      if with_shift and hovering_frame != frame:
        continue
      
      frame.rescale(is_up)
      
      
  if event is InputEventMouseMotion and prev_mouse_pos != Vector2.ZERO:
    for frame in get_children():
      if with_shift and hovering_frame != frame:
        continue
        
      frame.reposition(event.position - prev_mouse_pos)
      
    prev_mouse_pos = event.position
        


func _on_Grid_photo_mark_changed(photo, mark):
  for frame in get_children():
    if frame.photo == photo:
      if mark:
        frame.mark()
      else:
        frame.unmark()
      break

func _on_Grid_photo_selection_changed(photo, selection):
  for frame in get_children():
    if frame.photo == photo:
      if selection:
        frame.select()
      else:
        frame.unselect()
      break

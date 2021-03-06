extends VBoxContainer

signal thumb_parsed(photo)
signal photo_selection_changed(photo, selection)
signal photo_mark_changed(photo, mark)

var photos = []
var parsed_photo_count = 0

func show_folder_images(dir_path):
  $List.clear()
  update_dir(dir_path)
  
  parsed_photo_count = 0
  if Settings.sort_method >= Settings.SortMethod.ExifDateAscending:
    Util.Nodes["Main"].progress_init(photos.size(), "reading_exif_thumb")
    
  for idx in range(photos.size()):
    if Settings.sort_method < Settings.SortMethod.ExifDateAscending:
      $List.add_item("")
    Threading.pending_jobs.append(["get_raw_thumb", photos[idx], self, idx])
  
func _on_PhotoList_thumb_parsed(idx):
  parsed_photo_count += 1
  
  if Settings.sort_method >= Settings.SortMethod.ExifDateAscending:
    Util.Nodes["Main"].progress_set(parsed_photo_count)
    
    if parsed_photo_count == photos.size():
      photos.sort_custom(Photo.PhotoSorter, Settings.SortMethod.keys()[Settings.sort_method])
      for photo in photos:
        $List.add_item(photo.get_list_info(), photo.thumb_texture)
  else:
    $List.set_item_text(idx, photos[idx].get_list_info())
    $List.set_item_icon(idx, photos[idx].thumb_texture)
  
  
func index_limit(index):
  if index < 0:
    return 0
  elif index > photos.size() - 1:
    return photos.size() - 1
  else:
    return index
    
func show_next(amount):
  if amount == 0:
    amount = 1
    
  var selected_index_lst = $List.get_selected_items()
  var last_index = selected_index_lst[-1] if selected_index_lst.size() > 0 else -1
  var next_index = index_limit(last_index + 1)
  for i in range(amount):
    if next_index + i < photos.size():
      $List.select(next_index + i, i == 0)
    
  _on_Compare_pressed()
  
func show_prev(amount = 1):
  if amount == 0:
    amount = 1
  
  var selected_index_lst = $List.get_selected_items()
  var first_index = selected_index_lst[0] if selected_index_lst.size() > 0 else 1
  var prev_index = index_limit(first_index - 1)
  for i in range(amount):
    if prev_index - i >= 0:
      $List.select(prev_index - i, i == 0)
    
  _on_Compare_pressed()
  
func update_dir(dir_path):
  photos = []
  
  var extension_filter = Settings.extension_filter.duplicate()
  if Settings.display_jpeg:
    extension_filter.push_front("jpg")
    extension_filter.push_front("jpeg")
  
  var dir = Directory.new()
  if dir.open(dir_path) == OK:
    dir.list_dir_begin(true)
    var file_name = dir.get_next()
    while file_name != "":
      if not dir.current_is_dir():
        var extension_name = ("." + file_name).rsplit(".", true, 1)[1]
        if extension_name.to_lower() in extension_filter:
          photos.append(Photo.new(dir_path, file_name))

      file_name = dir.get_next()
  
  if Settings.sort_method < Settings.SortMethod.ExifDateAscending:
    photos.sort_custom(Photo.PhotoSorter, Settings.SortMethod.keys()[Settings.sort_method])
    
func get_selected_photos():
  var result = []
  for index in $List.get_selected_items():
    result.append(photos[index])
    
  return result
  
func get_marked_photos():
  var result = []
  for photo in photos:
    if photo.ui_marked:
      result.append(photo)
    
  return result

var compare_round = 0
var cache_mapping = {}
func _on_Compare_pressed():
  compare_round += 1
  
  var selected_photos = get_selected_photos()
  for photo in selected_photos:
    cache_mapping[photo] = compare_round

  for photo in cache_mapping.keys():
    if cache_mapping[photo] < compare_round - Settings.cache_round:
      photo.full_texture = ImageTexture.new()
      cache_mapping.erase(photo)
      
  Util.Nodes["Grid"].update_photos(selected_photos)
  
  
var with_alt = false
func _on_List_multi_selected(index, selected):
  if with_alt and selected:
    photos[index].toggle_mark()
    
  var selected_photos = get_selected_photos()
  for photo in photos:
    var curr_selected = selected_photos.has(photo)
    if curr_selected != photo.ui_selected:
      photo.toggle_selection()

func clean_cache():
  compare_round = 0
  cache_mapping = {}
  for photo in photos:
    photo.full_texture = ImageTexture.new()
    
func _on_List_gui_input(event):
  with_alt = event.alt
  if event is InputEventMouseButton and event.pressed and \
     event.doubleclick and get_selected_photos().size() == 1:
    _on_Compare_pressed()

func _on_PhotoList_photo_mark_changed(photo, mark):
  var idx = photos.find(photo)
  $List.set_item_custom_bg_color(idx, Settings.mark_color if mark else Color.transparent)
  $List.update()

func _on_PhotoList_photo_selection_changed(photo, selection):
  var idx = photos.find(photo)
  if selection:
    $List.select(idx, false)
  else:
    $List.unselect(idx)

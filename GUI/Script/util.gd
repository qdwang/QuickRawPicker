extends Node

enum LogLevel {Error, Critical, Info, Verbose}

onready var Bridge = preload("res://Asset/Lib/main_nativescript.gdns").new()
onready var is_windows = true if OS.get_name() == "Windows" else false
onready var log_time = OS.get_ticks_msec()
onready var log_level = LogLevel.keys()
onready var Nodes = {
  "PhotoList": get_node("/root/Main/PhotoList"),
  "Grid": get_node("/root/Main/Grid")  
}

const log_thd = 2

func log(msg, mark = "", level = LogLevel.Info):
  var data = ""
  if typeof(msg) == TYPE_ARRAY:
    for x in msg:
      data += str(x) + " "
  else:
    data = str(msg)
  
  if level <= log_thd:
    var now = OS.get_ticks_msec()
    print("%s[%s][%d]: %s" % [log_level[level], mark, now - log_time, data])
    log_time = now

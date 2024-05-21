extends Control

export(Vector2) var _start_position = Vector2(0, -20)
export(Vector2) var _end_position = Vector2.ZERO
export(float) var fade_in_duration = 0.3
export(float) var fade_out_duration = 0.2

onready var root = get_tree().get_root()
onready var scene_root = root.get_child(root.get_child_count() - 1)
onready var color_rect = $ColorRect
onready var tween = $Tween

onready var center_cont = $ColorRect/CenterContainer

onready var default_stats = {
   "level1":{
	  "archers_killed":0,
	  "collected_coins":0,
	  "completed":false,
	  "knights_killed":0,
	  "red_archers_killed":0,
	  "shield_knights_killed":0,
	  "skeletons_killed":0,
	  "time":null,
	  "yellow_archers_killed":0
	 },
	 "level2":{
	  "archers_killed":0,
	  "collected_coins":0,
	  "completed":false,
	  "knights_killed":0,
	  "red_archers_killed":0,
	  "shield_knights_killed":0,
	  "skeletons_killed":0,
	  "time":null,
	  "yellow_archers_killed":0
	 }
}
  

func _ready():
	open()
	var has_permissions: bool = false
			
#	
#
	MusicController.play_music()
	MusicController.set_volume_db(-15)
	
#	
func _process(_delta):
	pass
	
func open():
	show()

	tween.interpolate_property(color_rect, "modulate:a", 0.0, 1.0,
			fade_in_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(center_cont, "rect_position",
			_start_position, _end_position, fade_in_duration,
			Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()

func close():
	# Tween's interpolate_property has these arguments:
	# (Target object, "Property:OptionalSubProperty", From value, To value,
	# Tween duration, Transition type, Easing type, Optional delay)
	tween.interpolate_property(color_rect, "modulate:a", 1.0, 0.0,
			fade_out_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(center_cont, "rect_position",
			_end_position, _start_position, fade_out_duration,
			Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()

func _on_QuitButton_pressed():
	if not tween.is_active():
		close()
	
	# Cambio de escena quitar
	var t = Timer.new()
	t.set_wait_time(0.3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	get_tree().quit()

func _on_LevelsButton_pressed():
	if not tween.is_active():
		close()
	
	# Cambio de escena
	var t = Timer.new()
	t.set_wait_time(0.3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	return get_tree().change_scene("res://src/UserInterface/SelectLevelMenu.tscn")




func _on_CreditsButton_pressed():
	if not tween.is_active():
		close()
	
	# tiempo de espera entre escenas
	var t = Timer.new()
	t.set_wait_time(0.3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	return get_tree().change_scene("res://src/UserInterface/CreditsMenu.tscn")
	
func _on_Tween_tween_all_completed():
	if modulate.a < 0.5:
		hide()
		
func _check_files_path(path):
	var file2Check = File.new()
	return file2Check.file_exists(path)

#func _save_stats(path, stats_to_save):
#
#	var file = File.new()
#	file.open(path, File.WRITE)
#	file.store_line(to_json(stats_to_save))
#	file.close()


extends Node

onready var _pause_menu = $InterfaceLayer/PauseMenu
onready var _win_menu = $InterfaceLayer/WinMenu
onready var _death_menu = $InterfaceLayer/DeathMenu


func _init():
	OS.min_window_size = OS.window_size
	OS.max_window_size = OS.get_screen_size()


func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen

	elif event.is_action_pressed("toggle_pause"):
		
		get_tree().set_input_as_handled()
		if _death_menu.is_open or _win_menu.is_open:
			return
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			_pause_menu.open()
		else:
			_pause_menu.close()

	elif event.is_action_pressed("splitscreen"):
		if name == "Splitscreen":
			
			$Black/SplitContainer/ViewportContainer1.free()
			$Black.queue_free()
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://src/Main/Game.tscn")
		else:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://src/Main/Splitscreen.tscn")

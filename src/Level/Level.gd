extends Node2D

const LIMIT_LEFT = -315
const LIMIT_TOP = -250
const LIMIT_RIGHT = 955
const LIMIT_BOTTOM = 690

export var CAMERA_LIMIT = false
export var level_name = "level2"
export var current_stats_path = "user://current_stats.json"
export var stats_path = "user://stats.json"


var time_start = 0

var current_stats = {
	level_name:
		{
			"completed": false,
			"time":"00:00",
			"collected_coins":0,
			"skeletons_killed":0,
			"knights_killed":0,
			"shield_knights_killed":0,
			"archers_killed":0,
			"red_archers_killed":0,
			"yellow_archers_killed":0,
		}
	}
var default_stats = {
			"completed": false,
			"time":"00:00",
			"collected_coins":0,
			"skeletons_killed":0,
			"knights_killed":0,
			"shield_knights_killed":0,
			"archers_killed":0,
			"red_archers_killed":0,
			"yellow_archers_killed":0,
		}

var stats = {}

onready var _win_menu = $"../InterfaceLayer/WinMenu"

func _ready():

	
	for child in get_children():
		if child is Player:
			var camera = child.get_node("Camera")
			if CAMERA_LIMIT:
				camera.limit_left = LIMIT_LEFT
				camera.limit_top = LIMIT_TOP
				camera.limit_right = LIMIT_RIGHT
				camera.limit_bottom = LIMIT_BOTTOM
	
	
	var _player_path = get_node(@"./Player")
	var _enenemy_archer_path = get_children()
	_player_path.connect("collect_skull", self, "_collect_skull")
	_player_path.connect("collect_coin", self, "_update_current_stats", ["collected_coins"])

	# Prepara la puntuacion
	for child in get_children():
		if child is EnemyArcherEnhancedTypeA:
			child.connect("killed", self, "_update_current_stats", ["red_archers_killed"])
		elif child is EnemyArcherEnhancedTypeB:
			child.connect("killed", self, "_update_current_stats", ["yellow_archers_killed"])
		elif child is EnemyArcher:
			child.connect("killed", self, "_update_current_stats", ["archers_killed"])
		elif child is EnemyKnight:
			child.connect("killed", self, "_update_current_stats", ["knights_killed"])
		elif child is EnemyShield:
			child.connect("killed", self, "_update_current_stats", ["shield_knights_killed"])
		elif child is EnemySkeleton:
			child.connect("killed", self, "_update_current_stats", ["skeletons_killed"])
	
	time_start = OS.get_unix_time()
	
func _collect_skull():
	var elapsed = OS.get_unix_time() - time_start
	Stats.complete_level(level_name, elapsed)
func reset_stats():
	current_stats = default_stats

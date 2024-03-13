extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bgm_music_player : AudioStreamPlayer = $BGMMusicPlayer
onready var bgm_music = preload("res://assets/audio/bgm.wav")


# Called when the node enters the scene tree for the first time.
func _ready():
	bgm_music_player.stream = bgm_music
	bgm_music_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_QuitButton_pressed():
	get_tree().quit()

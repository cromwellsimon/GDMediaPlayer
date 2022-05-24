extends Control

export(PackedScene) var AudioPlayer_scene_path
export(PackedScene) var VideoPlayer_scene_path
export(PackedScene) var PhotoViewer_scene_path

var audio_player
var video_player
var photo_viewer

export(NodePath) var Popup_path
onready var popup : Popup = get_node(Popup_path)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	popup.popup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_FileDialog_file_selected(path):
	pass # Replace with function body.
	if (str(path).ends_with(".ogg")):
		audio_player = AudioPlayer_scene_path.instance()
		self.add_child(audio_player)
		var audio_stream = load(path)
		audio_player.play_stream(audio_stream)

extends Control

export(PackedScene) var AudioVideoPlayer_scene_path
export(PackedScene) var PhotoViewer_scene_path

var audio_video_player
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

func _input(_event):
	if(Input.is_action_just_pressed("open")):
		popup.popup()
		

func _on_FileDialog_file_selected(path):
	pass # Replace with function body.
	if (audio_video_player != null):
		audio_video_player.queue_free()
	if (photo_viewer != null):
		photo_viewer.queue_free()
	if (str(path).ends_with(".ogg")):
		instance_audio_video_player()
		var audio_stream = load(path)
		audio_video_player.play_audio_stream(audio_stream)
	elif (str(path).ends_with(".webm")):
		instance_audio_video_player()
		var video_stream = load(path)
		audio_video_player.play_video_stream(video_stream)
	elif (str(path).ends_with(".png")):
		instance_photo_viewer()
		var texture = load(path)
		photo_viewer.set_texture(texture)


func instance_audio_video_player():
	audio_video_player = AudioVideoPlayer_scene_path.instance()
	self.add_child(audio_video_player)
	
	
func instance_photo_viewer():
	photo_viewer = PhotoViewer_scene_path.instance()
	self.add_child(photo_viewer)

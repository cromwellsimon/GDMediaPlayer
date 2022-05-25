extends PanelContainer

export(NodePath) var AudioVideoControls_path
onready var controls = get_node(AudioVideoControls_path)

export(NodePath) var AudioStreamPlayer_path
onready var audio_stream_player : AudioStreamPlayer = get_node(AudioStreamPlayer_path)

export(NodePath) var VideoPlayer_path
onready var video_player : VideoPlayer = get_node(VideoPlayer_path)

var volume : float

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	update_volume()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if (audio_stream_player.is_playing()):
		controls.update_time_controls(audio_stream_player.get_playback_position())
	elif (video_player.is_playing()):
		controls.update_time_controls(video_player.get_stream_position())

func play_audio_stream(audio_stream) -> void:
	audio_stream_player.set_stream(audio_stream)
	audio_stream_player.play()
	controls.init_time_controls(audio_stream.get_length())

func play_video_stream(video_stream) -> void:
	video_player.set_stream(video_stream)
	video_player.play()
	# Turns out that there is no way to get the length of a video stream by default lol,
	# my only option would be to build from source and add that functionality myself
	#controls.init_time_controls(video_stream.get_length())


func update_volume() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume)


func _on_AudioVideoControls_on_play_pause_toggled(playing):
	pass # Replace with function body.
	if (audio_stream_player.is_playing()):
		audio_stream_player.set_stream_paused(!playing)
	elif (video_player.is_playing()):
		video_player.set_paused(!playing)


func _on_AudioVideoControls_on_volume_slider_changed(db):
	pass # Replace with function body.
	volume = db
	update_volume()

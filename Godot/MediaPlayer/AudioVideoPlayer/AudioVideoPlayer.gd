extends PanelContainer

export(NodePath) var AudioVideoControls_path
onready var controls = get_node(AudioVideoControls_path)

export(NodePath) var AudioStreamPlayer_path
onready var audio_stream_player : AudioStreamPlayer = get_node(AudioStreamPlayer_path)

export(NodePath) var VideoPlayer_path
onready var video_player : VideoPlayer = get_node(VideoPlayer_path)

onready var volume : float = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (audio_stream_player.is_playing() and !audio_stream_player.stream_paused):
		controls.update_time_controls(audio_stream_player.get_playback_position())
	elif (video_player.is_playing() and !video_player.paused):
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
		# The only way to be able to seek with this setup, since HSlider's
		# value_changed callback function is called regardless of who called it,
		# is to first pause the stream, set it, and then resume it.
		# I could have the stream automatically pause any time the user left-clicks
		# but in essence, this is how it has to be done lol
		if (audio_stream_player.stream_paused):
			audio_stream_player.seek(controls.time_slider.value)
		audio_stream_player.set_stream_paused(!playing)
	elif (video_player.is_playing()):
		# From the docs: Note, changing this value won't have any effect as seeking
		# is not implemented yet, except in video formats implemented by a GDNative add-on
		#if (video_player.paused):
		#	video_player.set_stream_position(controls.time_slider.value)
		video_player.set_paused(!playing)


func _on_AudioVideoControls_on_volume_slider_changed(db):
	pass # Replace with function body.
	volume = db
	update_volume()

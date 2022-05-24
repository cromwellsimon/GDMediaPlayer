extends AudioStreamPlayer

export(NodePath) var AVControls_path
onready var controls = get_node(AVControls_path)

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
	if (self.playing):
		controls.update_time_controls(self.get_playback_position())

func play_stream(audio_stream):
	self.set_stream(audio_stream)
	self.play()
	controls.init_time_controls(audio_stream.get_length())


func update_volume() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume)


func _on_Controls_on_volume_slider_changed(db):
	pass # Replace with function body.
	volume = db
	update_volume()

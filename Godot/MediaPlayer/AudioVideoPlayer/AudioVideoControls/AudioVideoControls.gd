extends VBoxContainer

export(NodePath) var PlayPause_path
onready var play_pause_button : Button = get_node(PlayPause_path)

export(NodePath) var TimeSlider_path
onready var time_slider : HSlider = get_node(TimeSlider_path)

export(NodePath) var TimeElapsed_path
onready var time_elapsed : Label = get_node(TimeElapsed_path)

export(NodePath) var VolumeSlider_path
onready var volume_slider : HSlider = get_node(VolumeSlider_path)

signal on_play_pause_toggled(playing)
signal on_volume_slider_changed(db)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_play_pause_button_text()
	init_volume_slider()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func init_time_controls(max_value):
	time_slider.max_value = stepify(max_value, 0.01)
	time_elapsed.text = "0/" + str(time_slider.max_value)


func update_time_controls(value):
	time_slider.value = stepify(value, 0.01)
	time_elapsed.text = str(time_slider.value) + "/" + str(time_slider.max_value)


func update_play_pause_button_text():
	if(!play_pause_button.pressed):
		play_pause_button.text = "Play"
	else:
		play_pause_button.text = "Pause"


func init_volume_slider():
	volume_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))


func _on_PlayPause_toggled(button_pressed):
	update_play_pause_button_text()
	emit_signal("on_play_pause_toggled", !button_pressed)


func _on_VolumeSlider_value_changed(value):
	emit_signal("on_volume_slider_changed", value)

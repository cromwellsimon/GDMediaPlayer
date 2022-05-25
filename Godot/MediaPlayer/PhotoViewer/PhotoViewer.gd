extends PanelContainer

export(NodePath) var TextureRect_path
onready var texture_rect : TextureRect = get_node(TextureRect_path)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_texture(texture):
	texture_rect.texture = texture

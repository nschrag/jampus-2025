class_name UpgradePanel extends Button

@export var id_icon: TextureRect
@export var level: Label
@export var title: Label
@export var description: RichTextLabel
@export var stats: RichTextLabel

func populate(next_level: int, def: UpgradeDefinition) -> void:
	level.text = str(next_level)
	title.text = def.name
	description.text = def.description
	if pressed.get_connections().size() == 0:
		push_warning("Button has no action assigned on press")

func _ready():
	connect("mouse_entered", big)
	connect("mouse_exited", small)
	pivot_offset = Vector2(size.x/2, size.y/2)

func big():
	var tween_big = create_tween().set_trans(Tween.TRANS_BACK)
	tween_big.tween_property(self, "scale", Vector2(1.1, 1.1), 0.5)

func small():
	var tween_small = create_tween().set_trans(Tween.TRANS_BACK)
	tween_small.tween_property(self, "scale", Vector2(1.0, 1.0), 0.5) 

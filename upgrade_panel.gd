class_name UpgradePanel extends Button

@export var id_icon: TextureRect
@export var level: Label
@export var title: Label
@export var description: RichTextLabel
@export var stats: RichTextLabel

signal selected(id: String)
var id: String

func populate(next_level: int, def: UpgradeDefinition) -> void:
	id = def.id
	level.text = str(next_level)
	title.text = def.name
	description.text = def.description

func _ready():
	pressed.connect(func(): selected.emit(id))
	connect("mouse_entered", big)
	connect("mouse_exited", small)
	pivot_offset = Vector2(size.x/2, size.y/2)

func big():
	var tween_big = create_tween().set_trans(Tween.TRANS_BACK)
	tween_big.tween_property(self, "scale", Vector2(1.1, 1.1), 0.5)

func small():
	var tween_small = create_tween().set_trans(Tween.TRANS_BACK)
	tween_small.tween_property(self, "scale", Vector2(1.0, 1.0), 0.5) 

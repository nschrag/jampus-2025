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
	mouse_entered.connect(func(): tween_scale(1.1))
	mouse_exited.connect(func(): tween_scale(1.0))
	pivot_offset = Vector2(size.x/2, size.y/2)

func tween_scale(target_scale: float):
	var t = create_tween().set_trans(Tween.TRANS_BACK)
	t.tween_property(self, "scale", Vector2(target_scale, target_scale), 0.5)

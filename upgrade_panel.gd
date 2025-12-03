class_name UpgradePanel extends PanelContainer

@export var icon: TextureRect
@export var level: Label
@export var title: Label
@export var description: RichTextLabel
@export var stats: RichTextLabel

func populate(def: UpgradeDefinition) -> void:
	title.text = def.name
	description.text = def.description

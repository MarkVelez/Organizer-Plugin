@tool
extends Button

signal closed

var parent
@onready var removeButton = %removeButton

var contents = {
	"title" : "",
	"description" : "",
	"checklist" : {}
}


func _ready() -> void:
	removeButton.icon = get_theme_icon("Close", "EditorIcons")


func itemClicked() -> void:
	if !is_queued_for_deletion():
		var itemContents = $"../../../../../../../../../itemContents"
		var itemContent = $"../../../../../../../../../itemContents/itemContent"
		itemContents.visible = true
		itemContent.contents = contents
		itemContent.item = self


func itemIsClosed() -> void:
	text = contents["title"]


func onMouseOver() -> void:
	removeButton.visible = true


func onMouseLeave() -> void:
	removeButton.visible = false


func onRemoveButtonPressed() -> void:
	parent.items.erase(name)
	queue_free()

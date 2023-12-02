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


func _ready():
	removeButton.icon = get_theme_icon("Close", "EditorIcons")


func itemClicked():
	if !is_queued_for_deletion():
		var itemContents = $"../../../../../../../../../itemContents"
		var itemContent = $"../../../../../../../../../itemContents/itemContent"
		itemContents.visible = true
		itemContent.contents = contents
		itemContent.item = self


func itemIsClosed():
	text = contents["title"]


func onMouseOver():
	removeButton.visible = true


func onMouseLeave():
	removeButton.visible = false


func onRemoveButtonPressed():
	parent.items.erase(name)
	queue_free()

@tool
extends Button

signal closed
signal parentChange(newParent: Object)

var parent: Object
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
		itemContent.columns.select(int(parent.name.trim_prefix("column")))


func itemIsClosed() -> void:
	text = contents["title"]
	parent.main.emit_signal("unsavedChanges")


func onMouseOver() -> void:
	removeButton.visible = true


func onMouseLeave() -> void:
	removeButton.visible = false


func onRemoveButtonPressed() -> void:
	parent.items.erase(name)
	queue_free()


func onParentChanged(newParent):
	parent.items.erase(self.name)
	newParent.items["item" + str(newParent.id)] = {
		"title" : contents["title"],
		"contents" : contents
	}
	reparent(newParent.itemList)
	self.name = "item" + str(newParent.id)
	parent = newParent

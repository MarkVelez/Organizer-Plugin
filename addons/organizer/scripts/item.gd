@tool
extends Button

signal closed

var contents = {
	"title" : "",
	"description" : "",
	"checklist" : {}
}

@onready var itemContents = $"../../../../../../../../../itemContents"
@onready var itemContent = $"../../../../../../../../../itemContents/itemContent"


func itemClicked():
	itemContents.visible = true
	itemContent.contents = contents
	itemContent.item = self


func itemIsClosed():
	text = contents["title"]

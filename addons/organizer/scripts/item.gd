@tool
extends Button

signal closed

var contents = {
	"title" : "",
	"description" : "",
	"checklist" : {}
}


func itemClicked():
	var itemContents = $"../../../../../../../../../itemContents"
	var itemContent = $"../../../../../../../../../itemContents/itemContent"
	itemContents.visible = true
	itemContent.contents = contents
	itemContent.item = self


func itemIsClosed():
	text = contents["title"]

@tool
extends PanelContainer

signal created
signal loaded

var items = {}
var parentTitle
var id = 0

const itemScene = preload("res://addons/organizer/uiElements/item.tscn")

@onready var main = $"../../../../../"
@onready var itemList = %itemList
@onready var columnTitle = %columnTitle
@onready var removeButton = %removeButton
@onready var addMenu = %addMenu
@onready var itemTitle = %itemTitle
@onready var closeButton = %closeButton


func whenCreated():
	columnTitle.set_text(parentTitle)
	removeButton.icon = get_theme_icon("Close", "EditorIcons")
	closeButton.icon = get_theme_icon("Close", "EditorIcons")


func addItemButton():
	addMenu.visible = true


func addButton():
	if checkIfTitleCorrect():
		createItem("item"+str(id), itemTitle.text, false)


func addMenuCloseButtonPressed():
	addMenu.visible = false
	itemTitle.clear()


func removeButtonPressed():
	main.columns.erase(name)
	queue_free()


func columnTitleChanged():
	main.columns[name]["title"] = columnTitle.text
	parentTitle = columnTitle.text


func checkIfTitleCorrect():
	if itemTitle.text.is_empty():
		return false
	else:
		return true


func createItem(indexedName: String, title: String, isLoad: bool):
	var item = itemScene.instantiate()
	item.name = indexedName
	item.text = title
	itemList.add_child(item)
	if isLoad:
		item.contents = main.data[self.name]["items"][indexedName]["contents"]
		id = int(indexedName.trim_prefix("item"))
	items[indexedName] = {
		"title" : title,
		"contents" : item.contents
	}
	id += 1
	item.contents["title"] = title
	item.parent = self
	addMenu.visible = false
	itemTitle.clear()


func whenLoaded():
	for item in main.data[self.name]["items"]:
		createItem(item, main.data[self.name]["items"][item]["title"], true)

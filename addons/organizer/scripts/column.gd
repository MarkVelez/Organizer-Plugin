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


func whenCreated() -> void:
	columnTitle.set_text(parentTitle)
	removeButton.icon = get_theme_icon("Close", "EditorIcons")
	closeButton.icon = get_theme_icon("Close", "EditorIcons")


func addItemButton() -> void:
	addMenu.visible = true


func addButton() -> void:
	if checkIfTitleCorrect():
		createItem("item"+str(id), itemTitle.text, false)


func addMenuCloseButtonPressed() -> void:
	addMenu.visible = false
	itemTitle.clear()


func removeButtonPressed() -> void:
	main.columns.erase(name)
	queue_free()


func columnTitleChanged() -> void:
	main.columns[name]["title"] = columnTitle.text
	parentTitle = columnTitle.text


func checkIfTitleCorrect() -> bool:
	if itemTitle.text.is_empty():
		return false
	else:
		return true


func createItem(indexedName: String, title: String, isLoad: bool) -> void:
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


func whenLoaded() -> void:
	for item in main.data[self.name]["items"]:
		createItem(item, main.data[self.name]["items"][item]["title"], true)

@tool
extends PanelContainer

signal created
signal loaded

var items: Dictionary
var parentTitle: String
var columnId: int
var id: int

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
	if checkIfTitleCorrect(itemTitle):
		createItem("item"+str(id), itemTitle.text)
		main.emit_signal("unsavedChanges")


func addMenuCloseButtonPressed() -> void:
	addMenu.visible = false
	itemTitle.clear()


func removeButtonPressed() -> void:
	main.columns.erase(self.name)
	main.itemContent.columns.remove_item(columnId)
	main.emit_signal("unsavedChanges")
	queue_free()
	main.updateColumnsIndexing()


func columnTitleChanged() -> void:
	if checkIfTitleCorrect(columnTitle):
		main.columns[self.name]["title"] = columnTitle.text
		main.itemContent.columns.set_item_text(columnId, columnTitle.text)
		parentTitle = columnTitle.text
		main.emit_signal("unsavedChanges")
	else:
		columnTitle.text = main.columns[self.name]["title"]


func checkIfTitleCorrect(title) -> bool:
	if title.text.is_empty():
		return false
	else:
		return true


func createItem(indexedName: String, title: String, isLoad = false) -> void:
	var item = itemScene.instantiate()
	item.name = indexedName
	item.text = title
	itemList.add_child(item)
	if isLoad:
		item.contents = main.storedData[self.name]["items"][indexedName]["contents"]
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
	id = 0
	for item in main.storedData[self.name]["items"]:
		createItem(item, main.storedData[self.name]["items"][item]["title"], true)


func updateItemsIndexing() -> void:
	id = 0
	await get_tree().create_timer(0).timeout
	for item in itemList.get_children():
		var indexedName = "item" + str(id)
		items.erase(item.name)
		item.name = indexedName
		items[indexedName] = {
			"title" : item.text,
			"contents" : item.contents
		}
		id += 1

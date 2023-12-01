@tool
extends PanelContainer

signal created

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


func whenCreated():
	columnTitle.set_text(parentTitle)
	removeButton.icon = get_theme_icon("Close", "EditorIcons")


func addItemButton():
	addMenu.visible = true


func addButton():
	if checkIfTitleCorrect():
		var itemTitleText = itemTitle.text
		var indexedName = "item"+str(id)
		var item = itemScene.instantiate()
		item.name = indexedName
		item.text = itemTitleText
		itemList.add_child(item)
		id += 1
		items[indexedName] = {
			"title" : itemTitleText,
			"contents" : item.contents
		}
		item.contents["title"] = itemTitleText
		item.parent = self
		addMenu.visible = false
		itemTitle.clear()


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

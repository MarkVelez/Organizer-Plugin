@tool
extends PanelContainer

var items = {}
var parentTitle
var id = 0

const itemScene = preload("res://addons/organizer/item.tscn")
const itemContentScene = preload("res://addons/organizer/itemContent.tscn")
@onready var main = $"../../../../../"
@onready var itemContent = $"../../../../../itemContents/itemContent"
@onready var itemList = $MarginContainer/VBoxContainer/itemList
@onready var columnTitle = $MarginContainer/VBoxContainer/HBoxContainer/columnTitle
@onready var removeButton = $MarginContainer/VBoxContainer/HBoxContainer/removeButton
@onready var itemTitle = $MarginContainer/VBoxContainer/addItem/addMenu/MarginContainer/VBoxContainer/itemTitle
@onready var addMenu = $MarginContainer/VBoxContainer/addItem/addMenu


func _ready():
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
		addMenu.visible = false
		itemTitle.clear()


func closeButton():
	addMenu.visible = false
	itemTitle.clear()


func closeButtonPressed():
	queue_free()


func columnTitleChanged():
	if columnTitle.text != parentTitle:
		main.columns[name]["title"] = columnTitle.text
		parentTitle = columnTitle.text


func checkIfTitleCorrect():
	if itemTitle.text.is_empty():
		return false
	else:
		return true

@tool
extends PanelContainer

signal unsavedChanges

var columns: Dictionary
var id: int

const columnScene = preload("res://addons/organizer/uiElements/column.tscn")
var data = dataManager.new()
var storedData = data.getData()

@onready var columnList = %columnList
@onready var itemContents = %itemContents
@onready var addMenu = %addMenu
@onready var columnTitle = %columnTitle
@onready var closeButton = %closeButton
@onready var itemContent = %itemContent


func _ready() -> void:
	closeButton.icon = get_theme_icon("Close", "EditorIcons")
	loadData()


func hasUnsavedChanges() -> void:
	data.saveData(columns)

func addColumnButton() -> void:
	addMenu.visible = true


func addButton() -> void:
	if checkIfTitleCorrect():
		createColumn("column"+str(id), columnTitle.text)


func onCloseButtonPressed() -> void:
	addMenu.visible = false
	columnTitle.clear()


func checkIfTitleCorrect() -> bool:
	if columnTitle.text.is_empty():
		return false
	else:
		return true


func createColumn(indexedName: String, title: String, isLoad = false) -> void:
	var column = columnScene.instantiate()
	column.name = indexedName
	column.parentTitle = title
	columnList.add_child(column)
	if isLoad:
		columns["column"+str(id)] = {
			"title" : title,
			"items" : storedData[indexedName]["items"]
		}
		column.emit_signal("loaded")
	else:
		columns[indexedName] = {
			"title" : title,
			"items" : column.items
		}
	itemContent.columns.add_item(title, id)
	itemContent.columns.set_item_metadata(id, column)
	column.columnId = id
	id += 1
	columnTitle.clear()
	column.emit_signal("created")
	addMenu.visible = false


func loadData() -> void:
	id = 0
	
	for column in storedData:
		createColumn(column, storedData[column]["title"], true)


func updateColumnsIndexing() -> void:
	id = 0
	await get_tree().create_timer(0).timeout
	itemContent.columns.set_item_count(columnList.get_child_count()+1)
	for column in columnList.get_children():
		var indexedName = "column" + str(id)
		columns.erase(column.name)
		column.name = indexedName
		columns[indexedName] = {
			"title" : column.columnTitle.text,
			"items" : column.items
		}
		itemContent.columns.set_item_id(column.columnId, id)
		column.columnId = id
		id += 1
	itemContent.columns.set_item_count(columnList.get_child_count())

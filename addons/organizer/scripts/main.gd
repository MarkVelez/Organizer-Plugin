@tool
extends PanelContainer

var columns = {}
var id = 0

const columnScene = preload("res://addons/organizer/uiElements/column.tscn")
var data = dataManager.new().getData()

@onready var columnList = %columnList
@onready var itemContents = %itemContents
@onready var addMenu = %addMenu
@onready var columnTitle = %columnTitle
@onready var closeButton = %closeButton


func _ready() -> void:
	closeButton.icon = get_theme_icon("Close", "EditorIcons")
	loadData()


func addColumnButton() -> void:
	addMenu.visible = true


func addButton() -> void:
	if checkIfTitleCorrect():
		createColumn("column"+str(id), columnTitle.text, false)


func onCloseButtonPressed() -> void:
	addMenu.visible = false
	columnTitle.clear()


func checkIfTitleCorrect() -> bool:
	if columnTitle.text.is_empty():
		return false
	else:
		return true


func createColumn(indexedName: String, title: String, isLoad: bool) -> void:
	var column = columnScene.instantiate()
	column.name = indexedName
	column.parentTitle = title
	columnList.add_child(column)
	if isLoad:
		columns[indexedName] = {
			"title" : title,
			"items" : data[indexedName]["items"]
		}
		id = int(indexedName.trim_prefix("column"))
		column.emit_signal("loaded")
	else:
		columns[indexedName] = {
			"title" : title,
			"items" : column.items
		}
	id += 1
	columnTitle.clear()
	column.emit_signal("created")
	addMenu.visible = false


func loadData() -> void:
	for column in data:
		createColumn(column, data[column]["title"], true)

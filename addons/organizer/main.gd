@tool
extends PanelContainer

var columns = {}
var id = 0

const columnScene = preload("res://addons/organizer/column.tscn")
@onready var columnList = $ScrollContainer/columnContainer/HBoxContainer/columnList
@onready var itemContents = $itemContents
@onready var addMenu = $ScrollContainer/columnContainer/HBoxContainer/addColumn/addMenu
@onready var columnTitle = $ScrollContainer/columnContainer/HBoxContainer/addColumn/addMenu/MarginContainer/VBoxContainer/columnTitle

func addColumnButton():
	addMenu.visible = true


func addButton():
	if checkIfTitleCorrect():
		var columnTitleText = columnTitle.text
		var indexedName = "column"+str(id)
		var column = columnScene.instantiate()
		column.name = indexedName
		column.parentTitle = columnTitleText
		columnList.add_child(column)
		id += 1
		columns[indexedName] = {
			"title" : columnTitleText,
			"items" : column.items
		}
		columnTitle.clear()
		addMenu.visible = false


func closeButton():
	addMenu.visible = false
	columnTitle.clear()


func checkIfTitleCorrect():
	if columnTitle.text.is_empty():
		return false
	else:
		return true

@tool
extends PanelContainer

const columnScene = preload("res://addons/organizer/column.tscn")
@onready var columnList = $ScrollContainer/columnContainer/columnList

var columns = {}


func addColumnButton():
	

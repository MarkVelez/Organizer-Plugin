@tool
extends Control

var contents: Dictionary
var item: Object
var id: int

const checklistItemScene = preload("res://addons/organizer/uiElements/checklistItem.tscn")

@onready var title = %itemTitle
@onready var description = %itemDescription
@onready var checklist = %checklistList
@onready var checklistProgress = %checklistProgress
@onready var closeButton = %closeButton
@onready var columns = %columns


func _ready() -> void:
	closeButton.icon = get_theme_icon("Close", "EditorIcons")


func closeButtonPressed() -> void:
	get_parent().visible = false
	checklistProgress.visible = false
	item.contents = contents
	item.emit_signal("closed")
	if columns.get_selected_metadata().name != item.parent.name:
		item.emit_signal("parentChange", columns.get_selected_metadata())
	columns.select(-1)


func isVisible() -> void:
	title.text = contents["title"]
	description.text = contents["description"]
	loadCheckList()
	updateProgress()


func titleChanged() -> void:
	if checkIfTitleCorrect():
		contents["title"] = title.text
	else:
		title.text = contents["title"]


func descriptionChanged() -> void:
	contents["description"] = description.text


func addCheckListItem() -> void:
	var checkbox = checklistItemScene.instantiate()
	var indexedName = "checkbox"+str(id)
	checkbox.name = indexedName
	checklist.add_child(checkbox)
	contents["checklist"][indexedName] = {
		"text" : "",
		"completed" : false
	}
	checkbox.emit_signal("created")
	if id == 0:
		checklistProgress.visible = true
	id += 1
	checklistProgress.max_value = contents["checklist"].size()


func loadCheckList() -> void:
	id = 0
	for children in checklist.get_children():
		children.free()
	
	for item in contents["checklist"]:
		var checkbox = checklistItemScene.instantiate()
		checkbox.name = item
		checklist.add_child(checkbox)
		checkbox.emit_signal("created")
		id += 1
	
	if id == 0:
		checklistProgress.visible = false
	else:
		checklistProgress.visible = true


func updateProgress() -> void:
	checklistProgress.max_value = contents["checklist"].size()
	checklistProgress.value = 0
	for item in contents["checklist"]:
		if contents["checklist"][item]["completed"]:
			checklistProgress.value += 1


func checkIfTitleCorrect() -> bool:
	if title.text.is_empty():
		return false
	else:
		return true

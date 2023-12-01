@tool
extends Control

var contents = {}
var item
var id = 0

const checklistItemScene = preload("res://addons/organizer/uiElements/checklistItem.tscn")

@onready var title = %itemTitle
@onready var description = %itemDescription
@onready var checklist = %checklistList
@onready var checklistProgress = %checklistProgress


func closeButtonPressed():
	get_parent().visible = false
	checklistProgress.visible = false
	item.contents = contents
	item.emit_signal("closed")


func isVisible():
	title.text = contents["title"]
	description.text = contents["description"]
	loadCheckList()
	updateProgress()
	if id > 0:
		checklistProgress.visible = true
	checklistProgress.max_value = id


func titleChanged():
	contents["title"] = title.text


func descriptionChanged():
	contents["description"] = description.text


func addCheckListItem():
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
	checklistProgress.max_value = id


func loadCheckList():
	id = 0
	for children in checklist.get_children():
		children.free()
	
	for item in contents["checklist"]:
		var checkbox = checklistItemScene.instantiate()
		checkbox.name = item
		checklist.add_child(checkbox)
		checkbox.emit_signal("created")
		id += 1


func updateProgress():
	checklistProgress.value = 0
	for item in contents["checklist"]:
		if contents["checklist"][item]["completed"]:
			checklistProgress.value += 1

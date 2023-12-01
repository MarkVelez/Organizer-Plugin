@tool
extends HBoxContainer

signal created

var itemContent
@onready var text = %text
@onready var checkbox = %checkbox
@onready var removeButton = %removeButton


func whenCreated():
	itemContent = $"../../../../../../"
	if itemContent.contents["checklist"].has(name):
		text.text = itemContent.contents["checklist"][name]["text"]
		checkbox.button_pressed = itemContent.contents["checklist"][name]["completed"]


func textChanged():
	itemContent.contents["checklist"][name]["text"] = text.text


func checkboxChecked(state):
	itemContent.contents["checklist"][name]["completed"] = state
	if state:
		itemContent.checklistProgress.value += 1
	else:
		itemContent.checklistProgress.value -= 1


func onMouseOver():
	removeButton.visible = true


func onMouseLeave():
	removeButton.visible = false


func onRemoveButtonPressed():
	itemContent.contents["checklist"].erase(name)
	itemContent.checklistProgress.max_value -= 1
	if itemContent.checklistProgress.max_value <= 0:
		itemContent.checklistProgress.visible = false
	else:
		itemContent.updateProgress()
	queue_free()

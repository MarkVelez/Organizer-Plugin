@tool
extends HBoxContainer

@onready var itemContent = $"../../../../../../"
@onready var text = %text
@onready var checkbox = %checkbox


func _ready():
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

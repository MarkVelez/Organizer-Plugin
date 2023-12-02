@tool
extends EditorPlugin

var mainScene
var data = dataManager.new()

func _enter_tree():
	mainScene = preload("res://addons/organizer/uiElements/main.tscn").instantiate()
	get_editor_interface().get_editor_main_screen().add_child(mainScene)
	_make_visible(false)


func _exit_tree():
	mainScene.free()


func _has_main_screen():
	return true


func _make_visible(visible):
	mainScene.visible = visible
	if !visible:
		data.saveData(mainScene.columns)


func _get_plugin_name():
	return "Organizer"


func _get_plugin_icon():
	return get_editor_interface().get_base_control().get_theme_icon("Window", "EditorIcons")

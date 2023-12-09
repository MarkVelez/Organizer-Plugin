@tool
extends EditorPlugin

var mainScene
var data = dataManager.new()

func _enter_tree() -> void:
	mainScene = preload("res://addons/organizer/uiElements/main.tscn").instantiate()
	get_editor_interface().get_editor_main_screen().add_child(mainScene)
	_make_visible(false)


func _exit_tree() -> void:
	mainScene.free()


func _has_main_screen() -> bool:
	return true


func _make_visible(visible) -> void:
	mainScene.visible = visible
	if !visible && mainScene.columns != data.getData():
		data.saveData(mainScene.columns)


func _get_plugin_name() -> String:
	return "Organizer"


func _get_plugin_icon() -> Texture2D:
	return load(get_script().resource_path.get_base_dir() + "/icon.svg")

@tool
class_name dataManager

var dataFolder = "res://addons/organizer/data/"
var fileName = "data.json"
var dataPath = dataFolder + fileName


func _ready() -> void:
	verifySaveDirectory(dataFolder)


func verifySaveDirectory(path: String) -> void:
	DirAccess.make_dir_absolute(path)


func saveData(data: Dictionary) -> void:
	var file = FileAccess.open(dataPath, FileAccess.WRITE)
	var jsonString =JSON.stringify(data, "\t")
	file.store_string(jsonString)
	file.close()


func getData() -> Dictionary:
	var file = FileAccess.open(dataPath, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	var data = JSON.parse_string(content)
	return data

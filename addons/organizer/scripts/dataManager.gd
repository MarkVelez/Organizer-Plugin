@tool
class_name dataManager

var dataFolder = "res://addons/organizer/data/"
var fileName = "data.json"
var dataPath = dataFolder + fileName


func _ready():
	verifySaveDirectory(dataFolder)


func verifySaveDirectory(path: String):
	DirAccess.make_dir_absolute(path)


func saveData(data: Dictionary):
	var file = FileAccess.open(dataPath, FileAccess.WRITE)
	if file == null:
		print(FileAccess.get_open_error())
		print("failed")
		return
	
	var jsonString =JSON.stringify(data, "\t")
	file.store_string(jsonString)
	file.close()

func getData():
	var file = FileAccess.open(dataPath, FileAccess.READ)
	if FileAccess.file_exists(dataPath):
		if file == null:
			print(FileAccess.get_open_error())
			return
		
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse %s as a json_string: (%s)" % [dataPath, content])
			return
		
		return data
	else:
		printerr("Cannot open non-existent file at %s!" % [dataPath])

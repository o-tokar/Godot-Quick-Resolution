@tool
class_name ResolutionPresetsGroup extends Resource

@export var preset_name: String
@export var resolutions: Array[DeviceResolution] = []

var __devices: Dictionary[String, DeviceResolution]


func refresh():
	__devices.clear()
	for res in resolutions:
		__devices[res.model] = res
		print("add "+res.model)


func get_resolution_by_device_model(_model: String) -> DeviceResolution:
	return __devices[_model]
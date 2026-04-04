@tool
class_name ResolutionGroupsCollection extends Resource

@export var title: String
@export var __preset_groups: Array[ResolutionPresetsGroup] = []

var __groups: Dictionary[String, ResolutionPresetsGroup]
var __active_group: ResolutionPresetsGroup

var groups: Array[ResolutionPresetsGroup]:
	get:
		return __groups.values()


func refresh():
	__groups.clear()
	for preset in __preset_groups:
		__groups[preset.preset_name] = preset

func get_preset_by_name(_preset_name: String) -> ResolutionPresetsGroup:
	__active_group = __groups[_preset_name]
	__active_group.refresh()
	return __groups[_preset_name]

func get_preset_by_index(idx: int) -> ResolutionPresetsGroup:
	return __groups.values()[idx]


func get_active_preset_resolution_by_device_model(_model: String) -> DeviceResolution:
	return __active_group.get_resolution_by_device_model(_model)

func get_active_preset_resolution_by_index(idx: int) -> DeviceResolution:
	return __active_group.resolutions[idx]

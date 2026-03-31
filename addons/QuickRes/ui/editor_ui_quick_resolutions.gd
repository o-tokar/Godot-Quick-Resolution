@tool
class_name QuickResolutionEditorUI extends Control

const __viewport_width_path: String = "display/window/size/viewport_width"
const __viewport_height_path: String = "display/window/size/viewport_height"

@export var __resolutions_options_display: OptionButton
@export var __check_box_orientation: CheckBox
@export var __groups_btns: ArrayBtnsSignalGroup
@export var __select_res: BaseButton
@export var __res: ResolutionPresets


var __plugin: EditorPlugin
var __is_landscape: bool

var __active_resolution: Vector2i = Vector2i.ZERO


func _exit_tree() -> void:
	Extras.disconnect_all(__select_res.pressed)
	Extras.disconnect_all(__check_box_orientation.pressed)
	Extras.disconnect_all(__resolutions_options_display.item_selected)


func _enter_tree() -> void:
	__res.refresh()

	__active_resolution = Vector2i(
		ProjectSettings.get_setting(__viewport_width_path),
		ProjectSettings.get_setting(__viewport_height_path))

	print("set-resolution: [width: {width} x height: {height}]".format({"width": __active_resolution.x, "height": __active_resolution.y}))

	__is_landscape = __active_resolution.x > __active_resolution.y
	__check_box_orientation.button_pressed = __is_landscape

	Extras.connect_once(__check_box_orientation.toggled, __switch_orientation)
	__resolutions_options_display.clear()

	for gr in __res.groups:
		__groups_btns.add(gr, __preset_selected)


func init(plugin: EditorPlugin):
	__plugin = plugin


func __preset_selected(_preset_name: String):
	__display_resolutions_list(__res.get_preset_by_name(_preset_name).resolutions)


func __display_resolutions_list(resolutions: Array[ResolutionData]):
	__resolutions_options_display.clear()

	for res in resolutions:
		var _wh = "[ {width}x{height} ]".format({"width": res.resolution.x, "height": res.resolution.y})
		__resolutions_options_display.add_item(res.device_name + " - " + _wh)

	Extras.connect_once(__resolutions_options_display.item_selected, __select_resolution)


func __select_resolution(idx: int):
	var resolution = __res.get_active_preset_resolution_by_index(idx).resolution
	__active_resolution = resolution
	_set_resolution(resolution)


func _set_resolution(v2i: Vector2i):
	var resolution = v2i

	if resolution == Vector2i.ZERO:
		return

	var width = resolution.x if not __is_landscape else resolution.y
	var height = resolution.y if not __is_landscape else resolution.x

	ProjectSettings.set_setting(__viewport_width_path, width)
	ProjectSettings.set_setting(__viewport_height_path, height)

	print("set-resolution: [width: {width} x height: {height}]".format({"width": width, "height": height}))
	# ProjectSettings.save()
	__plugin.refresh_2d_editor_view()


func __switch_orientation(is_landscape: bool):
	__is_landscape = is_landscape
	_set_resolution(__active_resolution)
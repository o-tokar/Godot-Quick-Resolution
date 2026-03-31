@tool
class_name HSliderSetWidget extends Control

@export var __slider: Slider
@export var __set_viewport_btn: BaseButton
@export var __set_window_override_btn: BaseButton
@export var __bounds: Vector2 = Vector2(1.0, 3.6)
@export var __range_label: Label

var _range: Vector2
## min./max range property.
var range:
	get:
		return Vector2(__slider.min_value, __slider.max_value)
	set(rg):
		_range = rg
		__slider.min_value = rg.x
		__slider.max_value = rg.y
		__slider.value = rg.x


signal on_set_viewport_rdp_signal(rdp: float)
signal on_set_window_override_rdp_signal(rdp: float)

func _ready():

	range = __bounds
	Extras.connect_once(__slider.value_changed, __on_value_changed)
	Extras.connect_once(__set_viewport_btn.pressed, __on_set_viewport_pressed)
	Extras.connect_once(__set_window_override_btn.pressed, __on_set_window_override_pressed)


func __on_value_changed(x):
	__range_label.text = "{v}".format({"v": snapped(x, 0.01)})


func __on_set_viewport_pressed():
	on_set_viewport_rdp_signal.emit(__slider.value)


func __on_set_window_override_pressed():
	on_set_window_override_rdp_signal.emit(__slider.value)

func _exit_tree():
	Extras.disconnect_all(__slider.value_changed)
	Extras.disconnect_all(__set_viewport_btn.pressed)
	Extras.disconnect_all(__set_window_override_btn.pressed)

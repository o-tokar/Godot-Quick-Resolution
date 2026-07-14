@tool
extends EditorPlugin
var __quick_resolution_editor: QuickResolutionEditorUI

func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _ready() -> void:
	var current_dir = get_script().resource_path.get_base_dir()
	__quick_resolution_editor = load(current_dir.path_join("/scenes/quick_resolution_editor_plugin.tscn")).instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, __quick_resolution_editor)
	__quick_resolution_editor.init(self, current_dir)

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_control_from_docks(__quick_resolution_editor)
	__quick_resolution_editor.free()


func refresh_2d_editor_view():
	update_overlays()

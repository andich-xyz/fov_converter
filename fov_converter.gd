extends Control

var width: int
var height: int
var vfov: float
var hfov: float
@onready var width_input: LineEdit = $aspect/VBoxContainer/HBoxContainer/PanelContainer/width_input
@onready var height_input: LineEdit = $aspect/VBoxContainer/HBoxContainer/PanelContainer2/height_input
@onready var vfov_input: SpinBox = $aspect/fov/HBoxContainer/PanelContainer/vfov_input
@onready var hfov_input: SpinBox = $aspect/fov/HBoxContainer2/PanelContainer/hfov_input

func _ready() -> void:
	width = width_input.text.to_int()
	height = height_input.text.to_int()
	vfov = vfov_input.value
	hfov = hfov_input.value

func _on_vfov_button_up() -> void:
	DisplayServer.clipboard_set(str(vfov))

func _on_hvof_button_up() -> void:
	DisplayServer.clipboard_set(str(hfov))

func calculate_fov(fov: float, is_input_vfov: bool) -> float:
	var aspect: float
	var calc_fov: float
	if is_input_vfov:
		aspect = float(width) / float(height)
	else:
		aspect = float(height) / float(width)
	calc_fov = 2 * atan(tan(deg_to_rad(fov) / 2) * aspect)
	return rad_to_deg(calc_fov)

#region Setters
func _on_width_input_text_changed(new_text: String) -> void:
	width = new_text.to_int()

func _on_height_input_text_changed(new_text: String) -> void:
	height = new_text.to_int()

func _on_vfov_input_value_changed(value: float) -> void:
	vfov = value
	hfov = calculate_fov(vfov, true)
	hfov_input.value = hfov

func _on_hfov_input_value_changed(value: float) -> void:
	hfov = value
	vfov = calculate_fov(hfov, false)
	vfov_input.value = vfov
#endregion

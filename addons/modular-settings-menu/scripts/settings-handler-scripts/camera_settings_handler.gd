extends Node

@export var camera: Camera3D


func _ready():
	# Connect neccessary signal
	SettingsDataManager.connect(&"apply_in_game_settings", apply_in_game_settings)


# Called to apply in game settings for the specific node
func apply_in_game_settings(section: StringName, element: StringName, _value) -> void:
	match element:
		&"FOV":
			# Set the camera FOV to the value stored in the settings data dictionary
			camera.set_fov(SettingsDataManager.SETTINGS_DATA[section][element])
		&"DepthOfField":
			var enabled: bool
			
			# Check if the current value of the element is disabled
			if SettingsDataManager.SETTINGS_DATA[section][element] == "Disabled":
				enabled = false
			else:
				enabled = true
			
			# Disable/Enable DOF
			camera.attributes.set_dof_blur_far_enabled(enabled)
			camera.attributes.set_dof_blur_near_enabled(enabled)

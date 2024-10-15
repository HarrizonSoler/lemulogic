extends Node

# key: StringName, value: Callable
var functions: Dictionary
var mod_path: StringName = "res://mods/tanks"

signal ENVIRONMENT_ENDED()

func set_functions(_functions: Dictionary) -> void:
	functions = _functions

func call_function(_name: StringName, args: Dictionary):
	if not functions.keys().has(_name):
		printerr("EnvironmentSingleton: function ", _name, " does not exist")
		return
	
	return functions[_name].call(args)

func set_path(_path: StringName) -> void:
	mod_path = _path

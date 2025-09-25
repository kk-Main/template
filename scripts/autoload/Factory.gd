extends Node
## 工厂类，负责创建各种对象，并在注册表中注册

## example_ui
var Example_UI = preload("res://scenes/example_ui.tscn")

## 创建 example
func creat_example() -> Example:
	var example = Example.new()
	Registry.registry_add_item("example", example, "logic_registry")
	return example

## 创建 example_ui
func creat_example_ui() -> ExampleUI:
	var example_ui = Example_UI.instantiate()
	Registry.registry_add_item("example_ui", example_ui, "ui_registry")
	return example_ui

## 创建 example_manager
func creat_example_manager() -> ExampleManager:
	var example_manager = ExampleManager.new()
	Registry.registry_add_item("example_manager", example_manager, "manager_registry")
	return example_manager

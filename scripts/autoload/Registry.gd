extends Node
## 注册表，记录所有已加载的对象

## 注册表项
class registry_item:
	var name: String
	var object: Object
	# 构造函数
	func _init(_name: String, _object) -> void:
		name = _name
		object = _object

## 注册表分组
class registry_group:
	var name: String
	var item_list: Array[registry_item]
	# 构造函数
	func _init(_name: String) -> void:
		name = _name
	# 按 name 查找项，返回索引，若不存在返回-1
	func _find_item(item_name: String) -> int:
		return item_list.find_custom(_is_item_name.bind(item_name))
	# 检查注册表组是否有指定名称
	func _is_item_name(obj: registry_item, item_name: String) -> bool:
		return obj.name == item_name
	# 在 item_list 中添加一个 item
	func group_add_item(item_name: String, item):
		if _find_item(item_name) == -1:
			item_list.append(registry_item.new(item_name, item))
	# 在 item_list 中查找符合名字的 item，成功则返回 item，失败则返回 null
	func group_find_item(item_name: String) -> registry_item:
		var item_index = _find_item(item_name)
		if item_index != -1:
			return item_list[item_index]
		else:
			return null

## 注册表分组列表
var group_list: Array[registry_group]


## 构造函数
func _init() -> void:
	_registry_add_group("ui_registry")
	_registry_add_group("manager_registry")
	_registry_add_group("logic_registry")


''' pravite '''

## 按 name 查找注册表组，返回索引，若不存在返回-1
func _find_group(group_name: String) -> int:
	return group_list.find_custom(_is_group_name.bind(group_name))

## 检查注册表组是否有指定名称
func _is_group_name(obj: registry_group, group_name: String) -> bool:
	return obj.name == group_name

## 新建注册表分组
func _registry_add_group(group_name: String) -> void:
	if _find_group(group_name) == -1:
		group_list.append(registry_group.new(group_name))
	else:
		push_error("group already exist")

''' public '''

## 在指定分组中中添加项
func registry_add_item(item_name: String, item, group_name: String) -> void:
	var group_index = _find_group(group_name)
	if group_index != -1:
		var group = group_list[group_index]
		if group.group_find_item(item_name) == null:
			group.group_add_item(item_name, item)

## 在指定分组中查找项，失败则返回 null
func registry_find_item(item_name: String, group_name: String):
	var group_index = _find_group(group_name)
	if group_index != -1:
		var group = group_list[group_index]
		var item = group.group_find_item(item_name)
		if item != null:
			return item.object
	return null

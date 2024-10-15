extends Camera2D

@export var tilemap: TileMapLayer

var target_size: Vector2 = Vector2.ZERO

func _ready() -> void:
	target_size = _get_tilemap_size(tilemap)

	# Center the camera on the tilemap
	offset = target_size / 2

func _process(_delta: float) -> void:
	set_zoom(_get_target_zoom(target_size))

func _get_tilemap_size(_tilemap: TileMapLayer) -> Vector2:
	return _tilemap.tile_set.tile_size * _tilemap.get_used_rect().size

func _get_target_zoom(_target_size: Vector2) -> Vector2:
	var _viewport_size := get_viewport_rect().size
	# Multiplied by 0.9 to get some margin around the tilemap
	var _zoom := _get_adjusted_viewport_and_target(_viewport_size, _target_size) * 0.9

	return Vector2(_zoom, _zoom)

func _get_adjusted_viewport_and_target(_viewport: Vector2, _target: Vector2) -> float:
	if _target.aspect() < _viewport.aspect():
		return float(_viewport.y) / _target.y

	return float(_viewport.x) / _target.x

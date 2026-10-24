extends Node3D

## The Card Class
##
## Includes utility methods for modifying cards.

## The card's number.
## 11-13 are face cards.
var num = 0
## The card's suit.
## 0 = club, 1 = spade, 2 = heart, 3 = diamond
var suit = 0

@onready var cardmesh = $CardMesh as MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_card_image(num, suit)


## Changes the current number and suit to the specified values.
## Calls set_card_image(cardnum, cardsuit).
func configure_card(cardnum = 1, cardsuit = 0) -> void:
	if (cardnum >= 1) && (cardnum <= 13):
		num = cardnum
	if (cardsuit >= 0) && (cardsuit <= 3):
		suit = cardsuit

	set_card_image(num, suit)

## Visually changes the current card number and suit.
## Works by shifting the uv1 of the material assigned to cardmesh.
func set_card_image(cardnum = 1, cardsuit = 0) -> void:
	match cardsuit:
		0:
			cardmesh.get_active_material(0).set_uv1_offset(Vector3(0.001 + ((cardnum - 1) * 0.077), 0, 0))
		1:
			cardmesh.get_active_material(0).set_uv1_offset(Vector3(0.001 + ((cardnum - 1) * 0.077), 0.25, 0))
		2:
			cardmesh.get_active_material(0).set_uv1_offset(Vector3(0.001 + ((cardnum - 1) * 0.077), 0.5, 0))
		3:
			cardmesh.get_active_material(0).set_uv1_offset(Vector3(0.001 + ((cardnum - 1) * 0.077), 0.75, 0))

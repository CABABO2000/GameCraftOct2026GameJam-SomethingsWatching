extends Node3D

@onready var GameManager = $".."/".."

var cards_in_hand = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func add_card_to_hand(card):
	cards_in_hand.append(card)
	card.rotation_degrees += Vector3(60, 0, 0)
	refactor_hand()

func refactor_hand():
	if len(cards_in_hand) == 1:
		cards_in_hand[0].position = Vector3(0, 0, 0)
	elif len(cards_in_hand) == 2:
		cards_in_hand[0].position = Vector3(-0.2, 0, 0)
		cards_in_hand[1].position = Vector3(0.2, 0, 0)
	else:
		cards_in_hand[0].position = Vector3(-0.5, 0, 0)
		for i in range(len(cards_in_hand)):
			cards_in_hand[i].position = Vector3(-0.5 + (i * (1 / float(len(cards_in_hand) - 1))), 0, 0)
	calc_hand_value()

func calc_hand_value() -> void:
	GameManager.player_hand_value = 0

	if len(cards_in_hand) == 0:
		GameManager.player_hand_value = 0

	var acecount = 0

	for i in range(len(cards_in_hand)):
		match cards_in_hand[i].num:
			1:
				acecount += 1
				GameManager.player_hand_value += 11
			var n when n < 11:
				GameManager.player_hand_value += cards_in_hand[i].num
			var n when n > 10:
				GameManager.player_hand_value += 10
	
	if acecount > 0 && GameManager.player_hand_value > 21:
		GameManager.player_hand_value -= 10 * acecount

	print(GameManager.player_hand_value)
extends Node3D

const cardscene = preload("res://scenes/Card.tscn")

var deck = ["DAce", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", "DJack", "DQueen", "DKing", "CAce", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10", "CJack", "CQueen", "CKing", "HAce", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H10", "HJack", "HQueen", "HKing", "SAce", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S10", "SJack", "SQueen", "SKing"]
var wager = 0

signal turn_action_taken
enum ACTION {HIT, STAND}
var currentaction = 0
signal turn_end

var player_hand_value = 0
var dealer_hand_value = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Hit.hide()
	$CanvasLayer/Stand.hide()

	await $CanvasLayer/WagerConfirm.button_up
	$CanvasLayer/WagerConfirm.hide()
	$CanvasLayer/Wager.hide()
	$CanvasLayer/Hit.show()
	$CanvasLayer/Stand.show()
	if !$CanvasLayer/Wager.text.is_empty():
		wager = $CanvasLayer/Wager.text.to_int()

	start_game()
	

func start_game():
	deck.shuffle()
	spawn_card_from_deck(0, Vector3(), true, true, false, true)
	spawn_card_from_deck(0, Vector3(), true, true, true, false)
	spawn_card_from_deck(0, Vector3(), false, true, false, true)
	spawn_card_from_deck(0, Vector3(), true, true, true, false)

	player_turn()
	await turn_end
	await dealer_turn()

	reset_game()

func player_turn():
	await turn_action_taken

	match currentaction:
		ACTION.HIT:
			spawn_card_from_deck(0, Vector3(), true, true, true, false)
			if player_hand_value > 21:
				player_lose()
		ACTION.STAND:
			await get_tree().create_timer(0.1).timeout
			turn_end.emit()


func dealer_turn():
	$DealerHand.cards_in_hand[1].rotation_degrees = Vector3()

	while(dealer_hand_value < player_hand_value || dealer_hand_value < 21):
		spawn_card_from_deck(0, Vector3(), true, true, false, true)
		print(str(dealer_hand_value) + " | " + str(player_hand_value))

	await get_tree().create_timer(1).timeout

func player_lose():
	reset_game()

func reset_game():
	deck = ["DAce", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", "DJack", "DQueen", "DKing", "CAce", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10", "CJack", "CQueen", "CKing", "HAce", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H10", "HJack", "HQueen", "HKing", "SAce", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S10", "SJack", "SQueen", "SKing"]
	player_hand_value = 0
	dealer_hand_value = 0
	wager = 0

	$Camera3D/PlayerHand.clear_hand()
	$DealerHand.clear_hand()

	$CanvasLayer/Hit.hide()
	$CanvasLayer/Stand.hide()
	$CanvasLayer/WagerConfirm.show()
	$CanvasLayer/Wager.show()

	await $CanvasLayer/WagerConfirm.button_up
	$CanvasLayer/WagerConfirm.hide()
	$CanvasLayer/Wager.hide()
	$CanvasLayer/Hit.show()
	$CanvasLayer/Stand.show()
	if !$CanvasLayer/Wager.text.is_empty():
		wager = $CanvasLayer/Wager.text.to_int()

	start_game()

## Spawns a card initialized with the specified properties at a specific location.
## cardnum must be less than 14 and cardsuit must be less than 4.
#func spawn_card_from_properties(cardnum, cardsuit, cardposition = Vector3(0,0,0), faceup = true) -> void:
#	var card = cardscene.instantiate()
#	add_child(card)
#
#	card.configure_card(cardnum,cardsuit)
#	card.name = str(card.num) + " " + str(card.suit)
#	card.position = cardposition
#	if !faceup:
#		card.rotation = Vector3(0, 0, PI);

## Spawns a card initialized with properties specified from the deck index at a specific location.
## deckindex must be less than 52.
func spawn_card_from_deck(deckindex, cardposition = Vector3(0,0,0), faceup = true, removefromdeck = true, toplayerhand = false, todealerhand = true):
	var card = cardscene.instantiate()
	add_child(card)

	var indexstats = parse_card_from_deck(deckindex)
	card.name = str(indexstats[0]) + " " + str(indexstats[1])
	card.configure_card(indexstats[0],indexstats[1])

	if toplayerhand:
		$Camera3D/PlayerHand.add_card_to_hand(card)
	elif todealerhand:
		$DealerHand.add_card_to_hand(card)
	else:
		card.position = cardposition

	if !faceup:
		card.rotation = Vector3(0, 0, PI);

	if removefromdeck:
		deck.remove_at(deckindex)

	return card

	
## Parses the String at the specified deck index for the card's number and suit.
## Returns an array of length 2; [0] is the number, [1] is the suit.
func parse_card_from_deck(deckindex):
	var cardstats = [1,0]

	if deck[deckindex].contains("S"):
		cardstats[1] = 1
	elif deck[deckindex].contains("H"):
		cardstats[1] = 2
	elif deck[deckindex].contains("D"):
		cardstats[1] = 3

	if deck[deckindex].contains("2"):
		cardstats[0] = 2
	elif deck[deckindex].contains("3"):
		cardstats[0] = 3
	elif deck[deckindex].contains("4"):
		cardstats[0] = 4
	elif deck[deckindex].contains("5"):
		cardstats[0] = 5
	elif deck[deckindex].contains("6"):
		cardstats[0] = 6
	elif deck[deckindex].contains("7"):
		cardstats[0] = 7
	elif deck[deckindex].contains("8"):
		cardstats[0] = 8
	elif deck[deckindex].contains("9"):
		cardstats[0] = 9
	elif deck[deckindex].contains("10"):
		cardstats[0] = 10
	elif deck[deckindex].contains("Jack"):
		cardstats[0] = 11
	elif deck[deckindex].contains("Queen"):
		cardstats[0] = 12
	elif deck[deckindex].contains("King"):
		cardstats[0] = 13
	return cardstats


func _on_stand_button_up() -> void:
	currentaction = ACTION.STAND
	turn_action_taken.emit()

func _on_hit_button_up() -> void:
	currentaction = ACTION.HIT
	turn_action_taken.emit()
	

extends Node3D

const cardscene = preload("res://scenes/card.tscn")

var deck = ["DAce", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", "DJack", "DQueen", "DKing", "CAce", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10", "CJack", "CQueen", "CKing", "HAce", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H10", "HJack", "HQueen", "HKing", "SAce", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S10", "SJack", "SQueen", "SKing"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_card_from_properties(1, 0, Vector3(0.5, 0, -1))
	deck.shuffle()
	spawn_card_from_deck(0, Vector3(0, 0, -0.5), false)


## Spawns a card initialized with the specified properties at a specific location.
## cardnum must be less than 14 and cardsuit must be less than 4.
func spawn_card_from_properties(cardnum, cardsuit, cardposition = Vector3(0,0,0), faceup = true) -> void:
	var card = cardscene.instantiate()
	add_child(card)

	card.configure_card(cardnum,cardsuit)
	card.position = cardposition
	if !faceup:
		card.rotation = Vector3(0, 0, PI);

## Spawns a card initialized with properties specified from the deck index at a specific location.
## deckindex must be less than 52.
func spawn_card_from_deck(deckindex, cardposition = Vector3(0,0,0), faceup = true) -> void:
	var card = cardscene.instantiate()
	add_child(card)

	var indexstats = parse_card_from_deck(deckindex)
	card.configure_card(indexstats[0],indexstats[1])

	card.position = cardposition
	if !faceup:
		card.rotation = Vector3(0, 0, PI);

	
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
	
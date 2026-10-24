using Godot;
using System;

public partial class GameManager : Node3D
{
	public static String[] Cards = null;
	public static String[] YouHand = null;
	public static String[] DealerHand = null;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		Cards = ["DAce", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", "DJack", "DQueen", "DKing", "CAce", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10", "CJack", "CQueen", "CKing", "HAce", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H10", "HJack", "HQueen", "HKing", "SAce", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S10", "SJack", "SQueen", "SKing"];
		GD.Print(Cards.Stringify());
		GD.Print(Cards.Length);

		YouHand = new string[2];
		DealerHand = new string[21];

		GD.Print("Dealing");
		Random rand = new Random(52);
		for(int i = 0; i < 2; i++) {
			YouHand[i] = Cards[rand.Next(0, 51)];
			GD.Print("You: " + YouHand[i]);
			DealerHand[i] = Cards[rand.Next(0, 51)]; // Currently does not care about repeats.
			GD.Print("Dealer: " + DealerHand[i]);
		}

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{

	}
}

import 'package:flutter/material.dart';

class CustomPopUp extends StatelessWidget {
  const CustomPopUp({
    super.key,
    required this.winner,
    required this.onCallback,
    required this.isTwoPlayer,
  });

  final String? winner;
  final void Function() onCallback;
  final bool isTwoPlayer;

  @override
  Widget build(context) {
    Widget title = Text(
      winner != 'Draw' ? 'You Win.' : 'Its a Draw.',
      style: TextStyle(
        color: winner != 'Draw' ? Colors.green : Colors.blue,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );

    if (winner == 'cancel') {
      title = const Text(
        'You lose.',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      );
    }

   Color color = winner == 'cancel' ? Colors.red : Colors.blue;
   String isTwoPlayerTitle =  winner == 'cancel' ? 'X wins.' : 'O wins';

    return AlertDialog(
      title: isTwoPlayer
          ? Text( winner != 'Draw' ? isTwoPlayerTitle : 'Draw',
              style: TextStyle(
                color: winner != 'Draw' ? color : Colors.green,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          : title,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: onCallback,
          child: const Text(
            'Try Again',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

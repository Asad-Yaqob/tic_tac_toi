import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicTacToeNotifier extends StateNotifier<List> {
  TicTacToeNotifier() : super(List.filled(9, null));
  bool isCircle = true;
  bool isTwoPlayer = false;
  String? winner;

  void handleTap(int index) {
    if (winner != null || state[index] != null) return;

    state[index] = isCircle ? 'circle' : 'cancel';
    isCircle = !isCircle;
    winner = checkWinner();

    if (!isTwoPlayer) {
      autoTap();
    }

    // Trigger state change to notify listeners
    state = List.of(state);
  }

  String? checkWinner() {
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombinations) {
      if (state[combo[0]] != null &&
          state[combo[0]] == state[combo[1]] &&
          state[combo[1]] == state[combo[2]]) {
        return state[combo[0]]; // Return 'circle' or 'cancel' as winner
      }
    }
    if (state.every((element) => element != null)) return 'Draw';
    return null;
  }

  void autoTap() {
    Future.delayed(const Duration(milliseconds: 500), () {
      int maxAttempts = state.length;

      for (var attempt = 0; attempt < maxAttempts; attempt++) {
        final randomCell = Random().nextInt(maxAttempts);

        if (winner != null) return;

        if (state[randomCell] == null) {
          state[randomCell] = isCircle ? 'circle' : 'cancel';
          isCircle = !isCircle;
          winner = checkWinner();

          // Trigger state change to notify listeners
          state = List.of(state);
          return;
        }
      }
    });
  }

  void resetGame() {
    state = List.filled(9, null);
    isCircle = true;
    isTwoPlayer = false;
    winner = null;
  }

  void toggleTwoPlayer() {
    isTwoPlayer = !isTwoPlayer;
  }
}

final ticTacToeProvider = StateNotifierProvider<TicTacToeNotifier, List>((ref) {
  return TicTacToeNotifier();
});

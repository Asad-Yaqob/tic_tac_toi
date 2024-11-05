import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toi/providers/tic_tac_toe.dart';

import 'package:tic_tac_toi/screens/splashscreen.dart';
import 'package:tic_tac_toi/widgets/tic_tac_cell.dart';
import 'package:tic_tac_toi/widgets/pop_up.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(ticTacToeProvider);
    final notifier = ref.watch(ticTacToeProvider.notifier);

  ref.listen(
    ticTacToeProvider.select(
    (state) => notifier.winner),
    (previousWinner, currentWinner){
      if (currentWinner != null) {
        _showPopUp(context, notifier.resetGame, currentWinner, notifier.isTwoPlayer);
      }
    });

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 62,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 5,
                ),
                onPressed: () {
                  notifier.resetGame();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Splashscreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.home,
                  size: 42,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 52,
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return TicTacCell(
                  winner: board[index],
                  onTap: () {
                    notifier.handleTap(index);
                  },
                  position: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

   void _showPopUp(BuildContext context, void Function() resetGame, String winner, bool isTwoPlayer){
    showGeneralDialog(
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: CustomPopUp(
              onCallback: (){
                 resetGame();
                Navigator.of(context).pop();
            },
              winner: winner,
              isTwoPlayer: isTwoPlayer,
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      barrierDismissible: false,
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
    );
  }


  // List<String?> _board = List.filled(9, null); // 3x3 board
  // bool _isCircle = true;
  // String? _winner;

 
  // void _handleTap(int index) {
  //   if (_board[index] != null || _winner != null) return;

  //   setState(() {
  //     _board[index] = _isCircle ? 'circle' : 'cancel';
  //     _isCircle = !_isCircle;
  //     _winner = _checkWinner();
  //   });

  //   if (!widget.isTwoPlayer) {
  //     _autoTap();
  //   }

  //   if (_winner != null || _winner == 'Draw') {
  //     _showPopUp();
  //   }
  // }

  // String? _checkWinner() {
  //   List<List<int>> winningCombinations = [
  //     [0, 1, 2],
  //     [3, 4, 5],
  //     [6, 7, 8],
  //     [0, 3, 6],
  //     [1, 4, 7],
  //     [2, 5, 8],
  //     [0, 4, 8],
  //     [2, 4, 6],
  //   ];

  //   for (var combo in winningCombinations) {
  //     if (_board[combo[0]] != null &&
  //         _board[combo[0]] == _board[combo[1]] &&
  //         _board[combo[1]] == _board[combo[2]]) {
  //       return _board[combo[0]]; // Return 'circle' or 'cancel' as winner
  //     }
  //   }
  //   if (_board.every((element) => element != null)) return 'Draw';
  //   return null;
  // }

  // void _resetGame() {
  //   Navigator.of(context).pop();
  //   setState(() {
  //     _board = List.filled(9, null);
  //     _isCircle = true;
  //     _winner = null;
  //   });
  // }

  // void _autoTap() {
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     int maxAttempts = _board.length;

  //     for (var attempt = 0; attempt < maxAttempts; attempt++) {
  //       final randomCell = Random().nextInt(maxAttempts);

  //       if (_winner != null) return;

  //       if (_board[randomCell] == null) {
  //         setState(() {
  //           _board[randomCell] = _isCircle ? 'circle' : 'cancel';
  //           _isCircle = !_isCircle;
  //           _winner = _checkWinner();
  //         });

  //         if (_winner != null || _winner == 'Draw') {
  //           _showPopUp();
  //         }
  //         return;
  //       }
  //     }
  //   });
  // }
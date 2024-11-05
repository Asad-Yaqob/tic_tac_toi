import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tic_tac_toi/providers/tic_tac_toe.dart';
import 'package:tic_tac_toi/screens/home.dart';
import 'package:tic_tac_toi/widgets/button.dart';

class Splashscreen extends ConsumerWidget {
  const Splashscreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toggleTwoPlayerNotifier = ref.read(ticTacToeProvider.notifier);

    void toggleTwoPlayer(BuildContext context){
      toggleTwoPlayerNotifier.toggleTwoPlayer();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tic-tac-toe.png',
              width: 200,
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'Tic Tac Toe',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            ),
            const SizedBox(
              height: 82,
            ),
            const CustomButton(
              label: 'Play',
            ),
            const SizedBox(
              height: 12,
            ),
            CustomButton.twoPlayer(
              label: 'Two Player',
              onPressed: (context) {
                toggleTwoPlayer(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

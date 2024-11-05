import 'package:flutter/material.dart';
import 'package:tic_tac_toi/screens/home.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.onPressed = navigateTo,
  }) : icon = Icons.play_arrow;

  const CustomButton.twoPlayer({
    super.key,
    required this.label,
    this.onPressed = navigateTo,
  }) : icon = Icons.person;

  final String label;
  final IconData icon;
  final void Function(BuildContext context)? onPressed;

  static void navigateTo(context) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: () {onPressed!(context);},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

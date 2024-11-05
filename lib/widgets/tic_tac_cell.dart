import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TicTacCell extends StatelessWidget {
  const TicTacCell({
    super.key,
    required this.winner,
    required this.onTap,
    required this.position,
  });

  final String? winner;
  final void Function() onTap;
  final int position;

  @override
  Widget build(BuildContext context) {
    BorderSide borderSide =
        BorderSide(color: Theme.of(context).colorScheme.secondary, width: 6);
        
    Widget content = winner == 'circle'
        ? const FaIcon(
            FontAwesomeIcons.circle,
            size: 80,
            color: Colors.blue,
          )
        : const FaIcon(
            FontAwesomeIcons.xmark,
            size: 80,
            color: Colors.red,
          );

    // Define borders conditionally for inner cells only
    Border cellBorder = Border(
      top: (position >= 3)
          ? borderSide
          : BorderSide.none, // Top border for rows 2 and 3
      left: (position % 3 != 0)
          ? borderSide
          : BorderSide.none, // Left border for columns 2 and 3
      right: (position % 3 != 2)
          ? borderSide
          : BorderSide.none, // Right border for columns 1 and 2
      bottom: (position < 6)
          ? borderSide
          : BorderSide.none, // Bottom border for rows 1 and 2
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: cellBorder,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: winner != null ? content : const SizedBox(),
      ),
    );
  }
}

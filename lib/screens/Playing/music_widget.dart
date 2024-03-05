import 'package:beatfusion/common/theme.dart';
import 'package:flutter/material.dart';

class MusicContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyTheme().secondaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: MyTheme().primaryColor,
            blurRadius: 4,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: MyTheme().primaryColor,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: MyTheme().primaryColor,
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: const Icon(
          Icons.music_note_rounded,
          color: Colors.white,
          size: 150,
        ),
      ),
    );
  }
}

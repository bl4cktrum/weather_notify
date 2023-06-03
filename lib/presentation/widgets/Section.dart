import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_notify/data/constants.dart';

class Section extends StatelessWidget {
  final int flex;
  final Widget child;

  const Section({
    Key? key,
    required this.flex,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        padding: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: AppColors.boxColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Color.lerp(AppColors.boxColor, AppColors.shadowColor, 0.3)!,
              offset: Offset(0, 20),
              blurRadius: 12,
              spreadRadius: -12,
            )
          ],
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}


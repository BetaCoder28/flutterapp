import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/themes/app_themes.dart';

class LoadingIndicator extends StatelessWidget {
  final double? size;
  final Color? color;

  const LoadingIndicator({super.key, this.size = 24, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.white),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .rotate(duration: 1000.ms);
  }
}

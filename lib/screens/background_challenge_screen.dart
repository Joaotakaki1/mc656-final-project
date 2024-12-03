import 'package:flutter/material.dart';

class BackgroundChallengeScreen extends StatelessWidget {
  final double progress;

  const BackgroundChallengeScreen({required this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      painter: BackgroundChallengePainter(progress: progress),
    );
  }
}

class BackgroundChallengePainter extends CustomPainter {
  final double progress;

  BackgroundChallengePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Altura do fundo ajustada pelo progresso
    final verticalOffset = size.height * (1 - progress);

    // Fundo rosa claro
    paint.color = Colors.pink.shade100;
    final path1 = Path();
    path1.moveTo(0, verticalOffset + size.height * 0.2);
    path1.quadraticBezierTo(
      size.width * 0.5,
      verticalOffset,
      size.width,
      verticalOffset + size.height * 0.2,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint);

    // Fundo rosa escuro
    paint.color = Colors.pink.shade300;
    final path2 = Path();
    path2.moveTo(0, verticalOffset + size.height * 0.25);
    path2.quadraticBezierTo(
      size.width * 0.5,
      verticalOffset + size.height * 0.1,
      size.width,
      verticalOffset + size.height * 0.25,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

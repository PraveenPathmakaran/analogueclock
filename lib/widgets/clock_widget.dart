import 'dart:math';

import 'package:analogueclock/ui/style.dart';
import 'package:analogueclock/utils/time_model.dart';
import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget(this.time, {super.key});
  final TimeModel time;

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppStryle.primaryColor.withAlpha(80),
            blurRadius: 38,
          )
        ],
      ),
      child: CustomPaint(
        painter: ClockPainter(widget.time),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  TimeModel? time;
  ClockPainter(this.time);
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX, centerY);

    //calculate the time position
    double secRad = ((pi / 2) - (pi / 30)) * time!.sec! % (2 * pi);
    double minRad = ((pi / 2) - (pi / 30)) * time!.min! % (2 * pi);
    double hourRad = ((pi / 2) - (pi / 30)) * time!.hour! % (2 * pi);

    //setting the clock coordinate

    double secHeight = radius / 2;
    double minHeight = radius / 2 - 10;
    double hourHeight = radius / 2 - 25;

    Offset seconds = Offset(
        centerX + secHeight * cos(secRad), centerY - secHeight * sin(secRad));
    Offset minutes = Offset(
        centerX + minHeight * cos(minRad), centerY - minHeight * sin(minRad));
    Offset hours = Offset(centerX + hourHeight * cos(hourRad),
        centerY - hourHeight * sin(hourRad));

    Paint fillBrush = Paint()
      ..color = AppStryle.primaryColorDark
      ..strokeCap = StrokeCap.round;
    Paint centerDotBrush = Paint()..color = const Color(0xFFEAECFF);

    Paint secBrush = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round;
    Paint minBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round;
    Paint hourBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4
      ..strokeJoin = StrokeJoin.round;

    //draw the body
    canvas.drawCircle(center, radius - 40, fillBrush);

    canvas.drawLine(center, seconds, secBrush);
    canvas.drawLine(center, minutes, minBrush);
    canvas.drawLine(center, hours, hourBrush);
    //draw center circle
    canvas.drawCircle(center, 16, centerDotBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

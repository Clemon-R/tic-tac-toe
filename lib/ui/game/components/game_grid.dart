import 'package:flutter/material.dart';
import 'package:tictactoe/domain/game/enums/unit_type_enum.dart';
import 'package:tictactoe/domain/game/models/player_model.dart';
import 'package:tictactoe/env/themes/basic_theme.dart';
import 'package:tictactoe/domain/game/models/game_model.dart';

class GameGrid extends StatelessWidget {
  final int size;
  final GameModel gameModel;
  final void Function(int posX, int posY) onTap;

  const GameGrid({
    super.key,
    required this.size,
    required this.gameModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.appTheme.horizontalPadding,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final gridSize = constraints.maxWidth;
          return SizedBox(
            width: gridSize,
            height: gridSize,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (details) {
                final offset = details.localPosition;
                final x = offset.dx;
                final y = offset.dy;
                final gridStep = gridSize / size;
                final offsetX = x % gridStep;
                final offsetY = y % gridStep;
                final shouldNotTakeIntoAccount =
                    offsetX < context.appTheme.horizontalPadding ||
                    gridSize - offsetX < context.appTheme.horizontalPadding ||
                    offsetY < context.appTheme.horizontalPadding ||
                    gridSize - offsetY < context.appTheme.horizontalPadding;
                if (shouldNotTakeIntoAccount) {
                  return;
                }
                final posX = x ~/ gridStep;
                final posY = y ~/ gridStep;
                onTap(posX, posY);
              },
              child: CustomPaint(
                size: Size.square(gridSize),
                painter: GameGridBackgroundPainter(
                  radius: context.appTheme.radius,
                  size: size,
                  lineOffset: context.appTheme.horizontalPadding,
                ),
                foregroundPainter: GameGridPlayerPainter(
                  unitPositions: gameModel.unitPositions,
                  size: size,
                  lineOffset: context.appTheme.horizontalPadding,
                ),
                child: const SizedBox.expand(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GameGridBackgroundPainter extends CustomPainter {
  final Radius radius;
  final double lineOffset;
  final int size;

  GameGridBackgroundPainter({
    required this.radius,
    required this.size,
    required this.lineOffset,
  });
  @override
  void paint(Canvas canvas, Size areaSize) {
    final width = areaSize.width;
    final height = areaSize.width;
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(RRect.fromLTRBR(0, 0, width, height, radius), paint);

    final heightStep = height / size;
    final widthStep = width / size;
    for (var i = 1; i < size; i++) {
      canvas.drawLine(
        Offset(lineOffset, i * heightStep),
        Offset(width - lineOffset, i * heightStep),
        paint,
      );
      canvas.drawLine(
        Offset(i * widthStep, lineOffset),
        Offset(i * widthStep, height - lineOffset),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool hitTest(Offset position) {
    return true;
  }
}

class GameGridPlayerPainter extends CustomPainter {
  final Map<Offset, PlayerModel> unitPositions;
  final int size;
  final double lineOffset;

  GameGridPlayerPainter({
    required this.unitPositions,
    required this.size,
    required this.lineOffset,
  });

  late double width;
  late double height;
  late double widthStep;
  late double heightStep;

  @override
  void paint(Canvas canvas, Size areaSize) {
    width = areaSize.width;
    height = areaSize.width;
    widthStep = width / size;
    heightStep = height / size;
    unitPositions.forEach((offset, playerModel) {
      _drawPlayer(canvas, offset, playerModel);
    });
  }

  void _drawPlayer(Canvas canvas, Offset offset, PlayerModel playerModel) {
    switch (playerModel.unitType) {
      case UnitTypeEnum.cross:
        _drawCross(canvas, offset);
        break;
      case UnitTypeEnum.circle:
        _drawCircle(canvas, offset);
        break;
    }
  }

  void _drawCircle(Canvas canvas, Offset offset) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(
      Offset(
        offset.dx * widthStep + widthStep / 2,
        offset.dy * heightStep + heightStep / 2,
      ),
      widthStep / 3,
      paint,
    );
  }

  void _drawCross(Canvas canvas, Offset offset) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(
        offset.dx * widthStep + lineOffset,
        (offset.dy + 1) * heightStep - lineOffset,
      ),
      Offset(
        (offset.dx + 1) * widthStep - lineOffset,
        offset.dy * heightStep + lineOffset,
      ),
      paint,
    );
    canvas.drawLine(
      Offset(
        offset.dx * widthStep + lineOffset,
        offset.dy * heightStep + lineOffset,
      ),
      Offset(
        (offset.dx + 1) * widthStep - lineOffset,
        (offset.dy + 1) * heightStep - lineOffset,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool hitTest(Offset position) {
    return true;
  }
}

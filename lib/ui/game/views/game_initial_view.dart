import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/domain/game/enums/unit_type_enum.dart';
import 'package:tictactoe/domain/game/models/game_model.dart';
import 'package:tictactoe/domain/game/models/player_model.dart';
import 'package:tictactoe/env/themes/basic_theme.dart';
import 'package:tictactoe/ui/components/common/app_header.dart';
import 'package:tictactoe/ui/components/layout/app_layout.dart';
import 'package:tictactoe/ui/game/components/game_grid.dart';
import 'package:tictactoe/ui/game/models/game_state_model.dart';

class GameInitialView extends StatefulWidget {
  final GameStateModelInitial state;
  final VoidCallback onStartGame;
  const GameInitialView({
    super.key,
    required this.state,
    required this.onStartGame,
  });

  @override
  State<GameInitialView> createState() => _GameInitialViewState();
}

class _GameInitialViewState extends State<GameInitialView>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat();
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Center(
        child: Stack(
          children: [
            Align(alignment: Alignment.topCenter, child: AppHeader()),
            Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _animation,
                child: SizedBox(
                  child: GameGrid(
                    size: 3,
                    gameModel: GameModel(
                      humanPlayer: PlayerModel(unitType: UnitTypeEnum.cross),
                      computerPlayer: PlayerModel(
                        unitType: UnitTypeEnum.circle,
                      ),
                      unitPositions: {
                        Offset(0, 0): PlayerModel(unitType: UnitTypeEnum.cross),
                        Offset(1, 1): PlayerModel(
                          unitType: UnitTypeEnum.circle,
                        ),
                        Offset(2, 2): PlayerModel(unitType: UnitTypeEnum.cross),
                      },
                    ),
                    onTap: (int posX, int posY) {},
                  ),
                ),
                builder: (context, child) {
                  return SizedBox(
                    width:
                        MediaQuery.of(context).size.width * 0.8 -
                        ((_animationController.value / 0.5).floor() * 0.5 -
                                    _animationController.value % 0.5)
                                .abs() *
                            200,
                    child: Transform.rotate(
                      angle:
                          ((_animationController.value / 0.5).floor() * 0.5 -
                                  _animationController.value % 0.5)
                              .abs() *
                          (pi / 4),
                      child: child,
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(context.appTheme.radius.x),
                child: InkWell(
                  onTap: widget.onStartGame,
                  borderRadius: BorderRadius.circular(
                    context.appTheme.radius.x,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(
                        context.appTheme.radius.x,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.appTheme.horizontalPadding,
                      vertical: context.appTheme.horizontalPadding / 2,
                    ),
                    child: Text(
                      "Start Game",
                      style: context.appTheme.buttonTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

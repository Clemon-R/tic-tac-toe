enum GameMessageEnum {
  none(""),
  invalidMove("You can't play this turn"),
  firstTurnForYou("You begin the game"),
  firstTurnForComputer("The computer begins the game");

  final String content;

  const GameMessageEnum(this.content);
}

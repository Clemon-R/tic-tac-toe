enum GameMessageEnum {
  none(""),
  invalidMove("You can't play this turn"),
  gameWon("You won the game"),
  gameLost("You lost the game"),
  gameTied("The game is tied");

  final String content;

  const GameMessageEnum(this.content);
}

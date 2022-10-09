import 'dart:math';
import 'NE_PAS_TOUCHER/user_input.dart';
import 'bot.dart';
import 'player.dart';

void main() {
  final nickName = readText("Entrez votre pseudo");
  final player = Player(nickname: nickName);
  int botCount = 0;
  while (player.isAlive) {
    final bot = Bot();
    bot.strength = max(1, player.strength - 1);
    var tour = 1;
    var isItPlayerTurn = Random().nextBool();
    print("Un bot se présente à vous et veut se battre...");
    do {
      readText("Appuyez sur entrez pour lancer les dés");
      if (isItPlayerTurn) {
        player.attackBot(bot: bot);
      } else {
        bot.attackPlayer(player: player);
      }
      player.displayYourData();
      bot.display();
      print("Fin du tour $tour");
      tour++;
      isItPlayerTurn = !isItPlayerTurn;
    } while (bot.isAlive && player.isAlive);
    if (player.isAlive) {
      print("${player.nickname} a vaincu le bot !");
      player.win(bot: bot);
      botCount++;
    }
  }
  print("${player.nickname} a vaincu $botCount bot(s) avant d'être terrassé !");
}

int rollTheDice({required String name}) {
  int dices = (Random().nextInt(6) + 1) + (Random().nextInt(6) + 1);
  print("$name a lancé les dés et a obtenu un $dices ");
  print("$name assène un coup sur le bot avec une force de $dices");
  return dices;
}

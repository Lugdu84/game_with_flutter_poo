import 'dart:math';
import 'NE_PAS_TOUCHER/user_input.dart';
import 'bot.dart';
import 'player.dart';

void main() {
  final player = Player();

  player.nickname = readText("Entrez votre pseudo");
  do {
    final bot = Bot();
    bot.strength = player.strength;
    var tour = 1;
    var isItPlayerTurn = Random().nextBool();
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
    } while (bot.health > 0 && player.health > 0);
    whoWin(player: player, bot: bot);
  } while (player.health > 0);
}

int rollTheDice({required String name}) {
  int dices = (Random().nextInt(6) + 1) + (Random().nextInt(6) + 1);
  print("$name a lancé les dés et a obtenu un $dices ");
  print("$name assène un coup sur le bot avec une force de $dices");
  return dices;
}

whoWin({required Player player, required Bot bot}) {
  if (player.health < 0) {
    print("Le bot vous a terrassé !");
  } else {
    print("${player.nickname} a vaincu le bot !");
    player.win(bot: bot);
  }
}

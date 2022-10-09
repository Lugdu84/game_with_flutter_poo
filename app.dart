// @dart=2.10
import 'dart:math';
import 'NE_PAS_TOUCHER/user_input.dart';
import 'bot.dart';
import 'player.dart';

void main() {
  final player = Player();
  final bot = Bot();
  player.nickname = readText("Entrez votre pseudo");
  var tour = 1;
  do {
    readText("Appuyez sur entrez pour lancer les dés");
    int first = Random().nextInt(1);
    if (first == 0) {
      playerAttackBot(player: player, bot: bot);
      botAttackPlayer(bot: bot, player: player);
    } else {
      botAttackPlayer(bot: bot, player: player);
      playerAttackBot(player: player, bot: bot);
    }
    print("Player - Santé ${player.health}%");
    print("Bot - Santé ${bot.health} %");
    print("Fin du tour $tour");
    tour++;
  } while (bot.health >= 0 || player.health >= 0);

  whoWin(player: player, bot: bot);
}

int rollTheDice() {
  return (Random().nextInt(6) + 1) + (Random().nextInt(6) + 1);
}

playerAttackBot({Player player, Bot bot}) {
  int dices = rollTheDice();
  print("${player.nickname} a lancé les dés et a obtenu un $dices ");
  print(
      "${player.nickname} assène un coup sur le bot avec une force de $dices");
  bot.health -= dices;
}

botAttackPlayer({Player player, Bot bot}) {
  int dices = rollTheDice();
  print("Le bot a lancé les dés et a obtenu un $dices ");
  print(
      "Le bot assène un coup sur ${player.nickname} avec une force de $dices");
  player.health -= dices;
}

whoWin({Player player, Bot bot}) {
  if (player.health < 0) {
    print("Le bot vous a terrassé ...");
  } else {
    print("Vous avez gagné la partie !");
  }
}

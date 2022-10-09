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
    int first = Random().nextInt(2);
    if (first == 0) {
      playerAttackBot(player: player, bot: bot);
      if (bot.health > 0) {
        botAttackPlayer(bot: bot, player: player);
      }
    } else {
      botAttackPlayer(bot: bot, player: player);
      if (player.health > 0) {
        playerAttackBot(player: player, bot: bot);
      }
    }
    infosPlayer(player: player);
    infosBot(bot: bot);
    print("Fin du tour $tour");
    tour++;
  } while (bot.health > 0 && player.health > 0);

  whoWin(player: player, bot: bot);
}

int rollTheDice({String name}) {
  int dices = (Random().nextInt(6) + 1) + (Random().nextInt(6) + 1);

  print("$name a lancé les dés et a obtenu un $dices ");
  print("$name assène un coup sur le bot avec une force de $dices");
  return dices;
}

playerAttackBot({Player player, Bot bot}) {
  int dices = rollTheDice(name: player.nickname);
  bot.health -= dices;
}

botAttackPlayer({Player player, Bot bot}) {
  int dices = rollTheDice(name: "Le bot");
  player.health -= dices;
}

whoWin({Player player, Bot bot}) {
  if (player.health < 0) {
    print("Le bot vous a terrassé !");
  } else {
    print("${player.nickname} a vaincu le bot !");
  }
}

infosPlayer({player: Player}) {
  print("${player.nickname} - Santé ${player.health}%");
}

infosBot({bot: Bot}) {
  print("Bot - Santé ${bot.health} %");
}

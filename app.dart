// @dart=2.10
import 'dart:math';
import 'NE_PAS_TOUCHER/user_input.dart';
import 'bot.dart';
import 'player.dart';

void main() {
  final player = Player();
  final bot = Bot();
  player.surnName = readText("Entrez votre pseudo");

  var tour = 1;
  do {
    readText("Appuyez sur entrez pour lancer les dés");
    bot.health -= rollTheDice(playerName: player.surnName);
    print("Bot - Santé ${bot.health} %");
    print("Fin du tour $tour");
    tour++;
  } while (bot.health > 0);

  print("Vous avez gagné la partie !");
}

int rollTheDice({String playerName}) {
  int dices = (Random().nextInt(6) + 1) + (Random().nextInt(6) + 1);
  print("$playerName a lancé les dés et a obtenu un $dices ");
  print("$playerName assène un coup sur le bot avec une force de $dices");
  return dices;
}

import 'dart:math';

import 'app.dart';
import 'player.dart';

class Bot {
  int strength = 1;
  int health = 100;

  bool get isAlive => health > 0;

  Bot({this.strength = 1});

  display() {
    print("Bot - Santé $health % - Force : $strength");
  }

  attackPlayer({required Player player}) {
    int dices = rollTheDice(name: "Le bot");
    final hitStrength = dices * strength;
    player.health = max(0, player.health - hitStrength);
  }
}

import 'dart:math';

import 'app.dart';
import 'bot.dart';

class Player {
  String nickname;
  int health = 100;
  int strength = 1;
  int xp = 0;

  bool get isAlive => health > 0;

  Player({required this.nickname});

  displayYourData() {
    print("$nickname - Santé $health % - Force : $strength");
  }

  attackBot({required Bot bot}) {
    int dices = rollTheDice(name: nickname);
    final hitStrength = dices * strength;
    bot.health = max(0, bot.health - hitStrength);
  }

  win({required Bot bot}) {
    strength += bot.strength;
    xp += bot.strength * 10;
    print(
        "$nickname a maintenant $xp points d'expérience et $strength points de force");
    takeHealingPotion(healingValue: 80);
    print("$nickname s'est reposé et à regagné tous ces points de vies");
  }

  takeHealingPotion({int healingValue = 50}) {
    health = min(100, health + healingValue);
  }

  raiseHealth({double factor = 1.4}) {
    final gain = health * factor;
    health = min(100, health + gain.toInt());
  }
}

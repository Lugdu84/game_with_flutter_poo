import 'dart:math';

import 'app.dart';
import 'bot.dart';

class Player {
  String nickname = "";
  int health = 100;
  int strength = 1;
  int xp = 0;

  displayYourData() {
    print("$nickname - Santé $health % - Force : $strength");
  }

  attackBot({bot: Bot}) {
    int dices = rollTheDice(name: nickname);
    final hitStrength = dices * strength;
    bot.health -= hitStrength;
  }

  win({required Bot bot}) {
    strength += bot.strength;
    xp += bot.strength * 10;
    print(
        "$nickname a maintenant $xp points d'expérience et $strength points de force");
    health = 100;
    print("$nickname s'est reposé et à regagné tous ces points de vies");
  }
}

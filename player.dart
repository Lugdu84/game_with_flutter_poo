import 'dart:math';

import 'app.dart';
import 'bot.dart';

class Player {
  String nickname = "";
  int health = 100;
  int strength = 1;
  int xp = 0;

  display() {
    print("$nickname - Santé $health % - Force : $strength");
  }

  attack({bot: Bot}) {
    int dices = rollTheDice(name: nickname);
    bot.health -= dices * strength;
  }

  victory({required Bot bot}) {
    strength += Random().nextInt(3);
    xp += bot.strength * 10;
    print(
        "$nickname a maintenant $xp points d'expérience et $strength points de force");
    health = 100;
    print("$nickname s'est reposé et à regagné tous ces points de vies");
  }
}

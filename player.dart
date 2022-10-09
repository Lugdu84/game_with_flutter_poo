import 'dart:math';

import 'NE_PAS_TOUCHER/user_input.dart';
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
    int choice = 1;
    if (health < 40) {
      do {
        print(
            "$nickname, Santé : $health % quelle action souhaitez vous faire ?");
        print("1 - Attaquer le bot");
        print("2 - Vous reposer pour récupérer de la santé");
        choice = readInt("Quel est votre choix ?");
      } while (choice < 1 || choice > 2);
    }

    if (choice == 1) {
      int dices = rollTheDice(name: nickname);
      final hitStrength = dices * strength;
      bot.health = max(0, bot.health - hitStrength);
    } else {
      raiseHealth();
    }
  }

  win({required Bot bot}) {
    strength += bot.strength;
    xp += bot.strength * 10;
    print(
        "$nickname a maintenant $xp points d'expérience et $strength points de force");
    takeHealingPotion(healingValue: 80);
    print("$nickname s'est reposé et à regagné tous ses points de vies");
  }

  takeHealingPotion({int healingValue = 50}) {
    health = min(100, health + healingValue);
  }

  raiseHealth({double factor = 1.4}) {
    final gain = health * factor;
    health = min(100, health + gain.toInt());
  }
}

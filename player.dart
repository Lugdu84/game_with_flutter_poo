import 'dart:math';

import 'NE_PAS_TOUCHER/user_input.dart';
import 'app.dart';
import 'bot.dart';

class Player {
  String _nickname;
  int _health = 100;
  int _strength = 1;
  int _xp = 0;

  int get strength => _strength;
  int get health => _health;
  String get nickname => _nickname;

  bool get isAlive => _health > 0;

  Player({required nickname}) : _nickname = nickname;

  displayYourData() {
    print("$nickname - Santé $_health % - Force : $_strength");
  }

  attackBot({required Bot bot}) {
    int userChoice = 1;
    if (_health < 40) {
      userChoice = selectFromMenu(
          message:
              '''$nickname, Santé : $_health % quelle action souhaitez vous faire ?
      1 - Attaquer le bot
      2 - Vous reposer pour récupérer de la santé ''',
          max: 2);
    }

    if (userChoice == 1) {
      int dices = rollTheDice(name: nickname);
      final hitStrength = dices * _strength;
      bot.isAttacked(hitStrength: hitStrength);
    } else {
      raiseHealth(factor: 0.75);
    }
  }

  win({required Bot bot}) {
    _strength += bot.strength;
    _xp += bot.strength * 10;
    print(
        "$nickname a maintenant $_xp points d'expérience et $_strength points de force");
    takeHealingPotion(healingValue: 80);
    print("$nickname s'est reposé et à regagné tous ses points de vies");
  }

  takeHealingPotion({int healingValue = 50}) {
    _health = min(100, _health + healingValue);
  }

  raiseHealth({double factor = 1.4}) {
    final gain = _health * factor;
    _health = min(100, _health + gain.toInt());
  }

  isAttacked({required int hitStrength}) {
    _health = max(0, _health - hitStrength);
  }
}

import 'dart:math';

import 'app.dart';
import 'player.dart';

class Bot {
  final int _strength;
  int _health = 100;

  int get health => _health;
  int get strength => _strength;
  bool get isAlive => health > 0;

  Bot({strength = 1}) : _strength = strength;

  display() {
    print("Bot - Santé $health % - Force : $_strength");
  }

  attackPlayer({required Player player}) {
    int dices = rollTheDice(name: "Le bot");
    final hitStrength = dices * _strength;
    player.isAttacked(hitStrength: hitStrength);
  }

  isAttacked({required int hitStrength}) {
    _health = max(0, _health - hitStrength);
  }
}

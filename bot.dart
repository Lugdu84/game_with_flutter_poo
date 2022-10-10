import 'dart:math';

import 'app.dart';
import 'fighter.dart';
import 'player.dart';

class Bot extends Fighter {
  Bot({strength = 1}) : super(strength: strength);

  display() {
    print("Bot - Santé $health % - Force : $strength");
  }

  attackPlayer({required Player player}) {
    int dices = rollTheDice(name: "Le bot");
    final hitStrength = dices * strength;
    player.isAttacked(hitStrength: hitStrength);
    print(
        "Le bot assène un coup sur ${player.nickname} avec une force de $hitStrength");
  }
}

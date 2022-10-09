import 'app.dart';
import 'player.dart';

class Bot {
  int strength = 1;
  int health = 100;

  display() {
    print("Bot - Santé $health % - Force : $strength");
  }

  attackPlayer({required Player player}) {
    int dices = rollTheDice(name: "Le bot") * strength;
    final hitStrength = dices * strength;
    player.health -= hitStrength;
  }
}

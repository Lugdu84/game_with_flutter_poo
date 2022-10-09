import 'app.dart';
import 'player.dart';

class Bot {
  int strength = 1;
  int health = 100;

  display() {
    print("Bot - Santé $health % - Force : $strength");
  }

  attack({required Player player}) {
    int dices = rollTheDice(name: "Le bot") * strength;
    player.health -= dices;
  }
}

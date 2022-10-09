import 'app.dart';
import 'bot.dart';

class Player {
  String nickname = "";
  int health = 100;
  int strength = 1;

  display() {
    print("$nickname - Santé $health % - Force : $strength");
  }

  attack({bot: Bot}) {
    int dices = rollTheDice(name: nickname);
    bot.health -= dices;
  }
}

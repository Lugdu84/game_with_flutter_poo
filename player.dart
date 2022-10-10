import 'dart:io';
import 'dart:math';
import 'NE_PAS_TOUCHER/user_input.dart';
import 'app.dart';
import 'bot.dart';
import 'fighter.dart';
import 'weapon.dart';
import 'weapon_list_manager.dart';

class Player extends Fighter implements Comparable<Player> {
  String _nickname;
  int _score = 0;
  Weapon _weapon = Weapon(name: "dague", powerful: 1, accuracy: 100);
  final _weaponListManager = WeaponListManager();

  String get nickname => _nickname;
  Weapon get weapon => _weapon;
  int get score => _score;

  Player({required nickname})
      : _nickname = nickname,
        super(strength: 1);

  attackOrRest({required Bot bot}) {
    int userChoice = 1;
    if (health < 40) {
      userChoice = selectFromMenu(
          message:
              '''$nickname, Santé : $health % quelle action souhaitez vous faire ?
      1 - Attaquer le bot
      2 - Vous reposer pour récupérer de la santé ''',
          max: 2);
    }

    if (userChoice == 1) {
      _attack(bot: bot);
    } else {
      raiseHealth(factor: 0.75);
    }
  }

  _attack({required Bot bot}) {
    int dices = rollTheDice(name: nickname);
    final hit = Random().nextInt(100) + 1;
    if (_weapon.accuracy >= hit) {
      final hitStrength = dices * (strength * _weapon.powerful);
      bot.isAttacked(hitStrength: hitStrength);
      print("$_nickname frappe le bot avec son ${_weapon.name}");
      print(
          "$_nickname assène un coup sur le bot avec une force de $hitStrength");
    } else {
      print("$_nickname a raté le bot");
    }
  }

  win({required Bot bot}) {
    strength += bot.strength;
    _score += bot.strength * health;
    print(
        "$nickname a maintenant $_score points d'expérience et $strength points de force");
    takeHealingPotion(healingValue: 80);
    print("$nickname s'est reposé et à regagné tous ses points de vies");
    final newWeapon = _weaponListManager.getNextWeaponToLoot();
    if (newWeapon != null) {
      final pickWeaponChoice = selectFromMenu(
          message:
              "Le bot a laissé tomber une arme (${newWeapon.description}), tapez 1 pour la ramasser ou 2 pour conserver votre arme (${_weapon.description})",
          max: 2);
      if (pickWeaponChoice == 1) {
        _weapon = newWeapon;
      }
    }
  }

  isAttacked({required int hitStrength}) {
    // _health = max(0, _health - hitStrength);
    health -= hitStrength;
  }

  @override
  displayYourData() {
    stdout.write(nickname);
    super.displayYourData();
  }

  prepareForNewGame() {
    health = 100;
  }

  @override
  int compareTo(Player other) => other.score.compareTo(score);
}

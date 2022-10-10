import 'dart:math';
import 'NE_PAS_TOUCHER/user_input.dart';
import 'app.dart';
import 'bot.dart';
import 'weapon.dart';
import 'weapon_list_manager.dart';

class Player {
  String _nickname;
  int _health = 100;
  int _strength = 1;
  int _xp = 0;
  Weapon _weapon;
  final _weaponListManager = WeaponListManager();

  int get strength => _strength;
  int get health => _health;
  String get nickname => _nickname;
  Weapon get weapon => _weapon;

  set strength(int strength) {
    _strength = max(0, strength);
  }

  set health(int health) {
    _health = max(0, health);
  }

  bool get isAlive => _health > 0;

  Player({required nickname, required weapon})
      : _nickname = nickname,
        _weapon = weapon;

  displayYourData() {
    print("$nickname - Santé $_health % - Force : $_strength");
  }

  attackOrRest({required Bot bot}) {
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
      _attack(bot: bot);
    } else {
      raiseHealth(factor: 0.75);
    }
  }

  _attack({required Bot bot}) {
    int dices = rollTheDice(name: nickname);
    final hit = Random().nextInt(100) + 1;
    if (_weapon.accuracy >= hit) {
      final hitStrength = dices * (_strength + _weapon.powerful);
      bot.isAttacked(hitStrength: hitStrength);
      print("$_nickname frappe le bot avec son ${_weapon.name}");
      print(
          "$_nickname assène un coup sur le bot avec une force de $hitStrength");
    } else {
      print("$_nickname a raté le bot");
    }
  }

  win({required Bot bot}) {
    _strength += bot.strength;
    _xp += bot.strength * 10;
    print(
        "$nickname a maintenant $_xp points d'expérience et $_strength points de force");
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

  takeHealingPotion({int healingValue = 50}) {
    _health = min(100, _health + healingValue);
  }

  raiseHealth({double factor = 1.4}) {
    final gain = _health * factor;
    _health = min(100, _health + gain.toInt());
  }

  isAttacked({required int hitStrength}) {
    // _health = max(0, _health - hitStrength);
    health -= hitStrength;
  }
}

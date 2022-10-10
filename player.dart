import 'dart:math';
import 'NE_PAS_TOUCHER/user_input.dart';
import 'app.dart';
import 'bot.dart';
import 'fighter.dart';
import 'weapon.dart';
import 'weapon_list_manager.dart';

class Player extends Fighter {
  String _nickname;
  int _xp = 0;
  Weapon _weapon;
  final _weaponListManager = WeaponListManager();

  String get nickname => _nickname;
  Weapon get weapon => _weapon;

  Player({required nickname, required weapon})
      : _nickname = nickname,
        _weapon = weapon,
        super(strength: 1);

  displayYourData() {
    print("$nickname - Santé $health % - Force : $strength");
  }

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
    _xp += bot.strength * 10;
    print(
        "$nickname a maintenant $_xp points d'expérience et $strength points de force");
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
    health = min(100, health + healingValue);
  }

  raiseHealth({double factor = 1.4}) {
    final gain = health * factor;
    health = min(100, health + gain.toInt());
  }

  isAttacked({required int hitStrength}) {
    // _health = max(0, _health - hitStrength);
    health -= hitStrength;
  }
}

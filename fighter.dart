import 'dart:math';

class Fighter {
  int _health = 100;
  int _strength;

  Fighter({required strength}) : _strength = strength;

  int get strength => _strength;
  int get health => _health;

  set strength(int strength) {
    _strength = max(0, strength);
  }

  set health(int health) {
    _health = max(0, health);
  }

  bool get isAlive => _health > 0;

  displayYourData() {
    print(" - Santé $health % - Force : $strength");
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

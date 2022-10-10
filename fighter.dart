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

  isAttacked({required int hitStrength}) {
    // _health = max(0, _health - hitStrength);
    health -= hitStrength;
  }
}

import 'weapon.dart';

class WeaponListManager {
  int _index = 0;

  int get index => _index;

  final _weapons = [
    Weapon(name: "vieux gourdin", powerful: 1, accuracy: 40),
    Weapon(name: "hache à une main", powerful: 2, accuracy: 60),
    Weapon(name: "épée longue à une main", powerful: 2, accuracy: 75),
    Weapon(name: "épée à deux mains", powerful: 4, accuracy: 40),
    Weapon(name: "épée enflamée à une main", powerful: 5, accuracy: 75),
    Weapon(name: "épée enflamée à deux mains", powerful: 6, accuracy: 40),
  ];

  Weapon? getNextWeaponToLoot() {
    Weapon? nextWeapon;
    if (_index < _weapons.length) {
      nextWeapon = _weapons[index];
      _index++;
    }
    return nextWeapon;
  }
}

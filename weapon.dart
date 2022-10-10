class Weapon {
  final String _name;
  final int _powerful;
  final int _accuracy;

  const Weapon({required name, required powerful, required accuracy})
      : _name = name,
        _powerful = powerful,
        _accuracy = accuracy;

  String get name => _name;
  int get powerful => _powerful;
  int get accuracy => _accuracy;

  String get description =>
      "$name - Puissance : $powerful - Précision : $accuracy %";
}

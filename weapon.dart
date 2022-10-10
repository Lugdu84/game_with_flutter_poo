class Weapon {
  final String _name;
  final int _powerful;
  final int _precision;

  const Weapon({required name, required powerful, required precision})
      : _name = name,
        _powerful = powerful,
        _precision = precision;

  String get name => _name;
  int get powerful => _powerful;
  int get precision => _precision;
}

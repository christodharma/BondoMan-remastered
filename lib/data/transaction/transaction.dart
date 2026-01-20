class Transaction {
  final int id;
  String? name;
  double? nominal;
  Category? category;
  String? location;
  DateTime? dateTime;

  static int _idCounter = 0;

  Transaction._(
    this.id,
    this.name,
    this.nominal,
    this.category,
    this.location,
    this.dateTime,
  );

  factory Transaction({
    required String name,
    required double nominal,
    required Category category,
    required String location,
    required DateTime dateTime,
  }) {
    var ret = Transaction._(
      _idCounter,
      name,
      nominal,
      category,
      location,
      dateTime,
    );
    _idCounter++;
    return ret;
  }
}

enum Category { send, receive }

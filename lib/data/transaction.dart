class Transaction {
  // final String id;
  String? name;
  double? nominal;
  Category? category;
  String? location;
  DateTime? dateTime;

  Transaction({
    required this.name,
    required this.nominal,
    required this.category,
    required this.location,
    required this.dateTime,
  });
}

enum Category { send, receive }

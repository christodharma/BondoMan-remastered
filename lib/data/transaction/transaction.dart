class Transaction {
  int? id;
  String? name;
  double? nominal;
  Category? category;
  String? location;
  DateTime? dateTime;

  Transaction({
    required this.id,
    required this.name,
    required this.nominal,
    required this.category,
    required this.location,
    required this.dateTime,
  });

  Transaction.withNoId({
    required this.name,
    required this.nominal,
    required this.category,
    required this.location,
    required this.dateTime,
  }) : id = null; // TODO make an UID generator

  Transaction.addId(Transaction old, int this.id)
    : name = old.name,
      nominal = old.nominal,
      category = old.category,
      location = old.location,
      dateTime = old.dateTime;

  @override
  bool operator ==(Object other) =>
      other is Transaction && other.id != null && id == other.id;

  bool approximately(Object other) {
    if (other is Transaction) {
      // other field == null -> not considering that field
      // but if all other field == null -> not considering at all -> false
      if (other.name == null &&
          other.nominal == null &&
          other.category == null &&
          other.location == null &&
          other.dateTime == null) {
        return false;
      }
      if (other.name != null && name != other.name) {
        return false;
      }
      if (other.nominal != null && nominal != other.nominal) {
        return false;
      }
      if (other.category != null && category != other.category) {
        return false;
      }
      if (other.location != null && location != other.location) {
        return false;
      }
      if (other.dateTime != null && dateTime != other.dateTime) {
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => id.hashCode;
}

enum Category { send, receive }

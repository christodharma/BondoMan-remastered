import 'transaction.dart';

class TransactionDbQueryBuilder {
  int? id;
  String? name;
  double? nominal;
  Category? category;
  String? location;
  DateTime? dateTime;

  TransactionDbQueryBuilder withId(int id) {
    this.id = id;
    return this;
  }

  TransactionDbQueryBuilder withName(String name) {
    this.name = name;
    return this;
  }

  TransactionDbQueryBuilder withNominal(double nominal) {
    this.nominal = nominal;
    return this;
  }

  TransactionDbQueryBuilder withCategory(Category category) {
    this.category = category;
    return this;
  }

  TransactionDbQueryBuilder withLocation(String location) {
    this.location = location;
    return this;
  }

  TransactionDbQueryBuilder withDateTime(DateTime dateTime) {
    this.dateTime = dateTime;
    return this;
  }

  Transaction build() {
    if (id != null) {
      return Transaction(
        id: id,
        name: name,
        nominal: nominal,
        category: category,
        location: location,
        dateTime: dateTime,
      );
    }
    return Transaction.withNoId(
      name: name,
      nominal: nominal,
      category: category,
      location: location,
      dateTime: dateTime,
    );
  }
}

import 'package:flutter_project_1/data/transaction/i_transaction_db.dart';
import 'package:flutter_project_1/data/transaction/mock_transaction_db.dart';
import 'package:flutter_project_1/data/transaction/transaction.dart';
import 'package:flutter_project_1/data/transaction/transaction_db_query.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ITransactionDb db;
  late Transaction transaction1 = Transaction.withNoId(
    "Es Teler",
    25000,
    .send,
    "Malang",
    DateTime(25, 5, 27),
  );
  late Transaction transaction2 = Transaction.withNoId(
    "Es Doger",
    20000,
    .send,
    "Malang",
    DateTime(25, 5, 27),
  );

  setUp(() {
    db = MockTransactionDb();
  });

  tearDown(() {
    var mockDb = db as MockTransactionDb;
    mockDb.dispose();
    db = mockDb;
  });

  test("create", () async {
    await db.create(transaction1);
    final newDb = await db.readAll();
    expect(newDb.length, 1);

    expect(newDb[0].id, 1);
  });

  test("create and read", () async {
    await db.create(transaction1);
    await db.create(transaction2);
    final query = await db.read(
      TransactionDbQueryBuilder().withName("Es Doger").build(),
    );

    expect(query.length, 1);
    expect(query[0].id, 2);
  });

  test("create, read, and update", () async {
    await db.create(transaction1);
    var resultId;
    final beforeUpdate = await db.read(
      TransactionDbQueryBuilder().withName("Es Teler").build(),
    );
    resultId = beforeUpdate[0].id;

    // update
    beforeUpdate[0].name = "Es Degan";
    await db.update(beforeUpdate[0]);

    // check by reread
    db.read(TransactionDbQueryBuilder().withId(resultId).build()).then((
      result,
    ) {
      expect(result[0].name, isNot("Es Teler"));
    });
  });

  test("create, read, and delete", () async {
    await db.create(transaction1);
    await db.create(transaction2);

    final beforeDelete = await db.read(
      TransactionDbQueryBuilder().withId(1).build(),
    );
    var resultId = beforeDelete[0].id!;
    expect(resultId, 1);

    // delete
    var deleteSuccess = await db.delete(
      TransactionDbQueryBuilder().withId(resultId).build()
    );
    expect(deleteSuccess, true);

    // check by reread
    db.read(TransactionDbQueryBuilder().withId(resultId).build()).then((
      result,
    ) {
      expect(result.length, 0);
    });
  });
}

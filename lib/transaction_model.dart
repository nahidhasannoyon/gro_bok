// transaction_model.dart
import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 1)
class TransactionModel extends HiveObject {
  @HiveField(0)
  late String bookId;

  @HiveField(1)
  late String type; // "income" or "expense"

  @HiveField(2)
  late double amount;

  @HiveField(3)
  late DateTime date;

  TransactionModel(this.bookId, this.type, this.amount, this.date);
}

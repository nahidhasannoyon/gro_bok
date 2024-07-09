// book_model.dart
import 'package:hive/hive.dart';

part 'book_model.g.dart';

@HiveType(typeId: 0)
class BookModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String id;

  @HiveField(2)
  late String category;

  BookModel(this.name, this.id, this.category);
}

// book_list_screen.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'book_model.dart';
import 'book_detail_screen.dart';
import 'add_book_screen.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: FutureBuilder(
        future: Hive.openBox<BookModel>('books'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var booksBox = Hive.box<BookModel>('books');
            return ListView.builder(
              itemCount: booksBox.length,
              itemBuilder: (context, index) {
                BookModel book = booksBox.getAt(index)!;
                return ListTile(
                  title: Text(book.name),
                  subtitle: Text(book.category),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// add_transaction_screen.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'book_model.dart';
import 'transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  final BookModel book;

  const AddTransactionScreen(this.book, {super.key});

  @override
  AddTransactionScreenState createState() => AddTransactionScreenState();
}

class AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController amountController = TextEditingController();
  late String transactionType;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    transactionType = 'income'; // Default transaction type
    selectedDate = DateTime.now(); // Default date
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: 'income',
                  groupValue: transactionType,
                  onChanged: (value) {
                    setState(() {
                      transactionType = value.toString();
                    });
                  },
                ),
                const Text('Income'),
                Radio(
                  value: 'expense',
                  groupValue: transactionType,
                  onChanged: (value) {
                    setState(() {
                      transactionType = value.toString();
                    });
                  },
                ),
                const Text('Expense'),
              ],
            ),
            TextField(
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                var transactionsBox =
                    Hive.box<TransactionModel>('transactions');
                await transactionsBox.add(TransactionModel(
                  widget.book.id,
                  transactionType,
                  double.parse(amountController.text),
                  selectedDate,
                ));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

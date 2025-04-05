import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({Key? key}) : super(key: key);

  List<Expense> get _mockExpenses => [
        Expense(
          id: '1',
          amount: 25.99,
          category: 'Food',
          date: DateTime.now().subtract(const Duration(days: 1)),
          notes: 'Lunch with colleagues',
        ),
        Expense(
          id: '2',
          amount: 45.50,
          category: 'Transportation',
          date: DateTime.now().subtract(const Duration(days: 2)),
          notes: 'Uber rides',
        ),
        Expense(
          id: '3',
          amount: 120.00,
          category: 'Shopping',
          date: DateTime.now().subtract(const Duration(days: 3)),
          notes: 'New headphones',
        ),
        Expense(
          id: '4',
          amount: 75.00,
          category: 'Bills',
          date: DateTime.now().subtract(const Duration(days: 4)),
          notes: 'Electricity bill',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _mockExpenses.length,
      itemBuilder: (context, index) {
        final expense = _mockExpenses[index];
        return Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getCategoryColor(expense.category),
              child: Icon(
                _getCategoryIcon(expense.category),
                color: Colors.white,
              ),
            ),
            title: Text(
              '\$${expense.amount.toStringAsFixed(2)} - ${expense.category}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDate(expense.date),
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                if (expense.notes != null && expense.notes!.isNotEmpty)
                  Text(
                    expense.notes!,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text('Delete Expense'),
                    content: const Text(
                      'Are you sure you want to delete this expense?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Delete functionality coming soon'),
                            ),
                          );
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Colors.orange;
      case 'transportation':
        return Colors.blue;
      case 'shopping':
        return Colors.purple;
      case 'bills':
        return Colors.red;
      case 'entertainment':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant;
      case 'transportation':
        return Icons.directions_car;
      case 'shopping':
        return Icons.shopping_bag;
      case 'bills':
        return Icons.receipt;
      case 'entertainment':
        return Icons.movie;
      default:
        return Icons.attach_money;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

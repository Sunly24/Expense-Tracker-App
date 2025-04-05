import 'package:flutter/material.dart';
import '../widgets/expense_list_screen.dart';
import '../widgets/add_expense_screen.dart';
import '../widgets/analytics_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const ExpenseListScreen(),
      const AddExpenseScreen(),
      const AnalyticsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined, color: Colors.white),
            label: 'Expenses',
            activeIcon: Icon(Icons.list_alt, color: Colors.white),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, color: Colors.white),
            label: 'Add',
            activeIcon: Icon(Icons.add_circle, color: Colors.white),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined, color: Colors.white),
            label: 'Analytics',
            activeIcon: Icon(Icons.analytics, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

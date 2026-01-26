import 'package:flutter/material.dart';
import 'package:flutter_project_1/ui/settings.dart';
import 'package:flutter_project_1/ui/graphs/graphs.dart';
import 'package:flutter_project_1/ui/history/history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentItemIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const History(),
    const Graphs(),
    const Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_currentItemIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: "Cashflow",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _currentItemIndex,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).colorScheme.surface,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        showUnselectedLabels: false,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mytaskmanager/screen/cancelled_task_screen.dart';
import 'package:mytaskmanager/screen/completed_task_screen.dart';
import 'package:mytaskmanager/screen/new_task_screen.dart';
import 'package:mytaskmanager/screen/progress_task_screen.dart';

import '../widgets/tmappbar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> screen = [
    const NewTaskScreen(),
    const ProgressTaskScreen(),
    const CompletedTaskScreen(),
    const CancelledTasked(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: screen[_selectedIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            _selectedIndex = index;
            setState(() {});
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.new_label), label: 'new'),
            NavigationDestination(
                icon: Icon(Icons.ac_unit_sharp), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Complete'),
            NavigationDestination(
                icon: Icon(Icons.cancel_outlined), label: 'Cancelled')
          ]),
    );
  }
}

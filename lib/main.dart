import 'package:flutter/material.dart';
import 'package:model_lerning_new_project/function_screen.dart';
import 'package:model_lerning_new_project/homeScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData()..loadTasksFromPrefs(),
      child: MaterialApp(
        title: 'To Do App',
        theme: ThemeData(primarySwatch: Colors.green),
        home: TasksScreen(),
      ),
    );
  }
}

/// using shared preference and provider


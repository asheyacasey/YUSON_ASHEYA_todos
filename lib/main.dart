import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_todo_app/src/app.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todos');
  await Hive.openBox('accounts');
  await Hive.openBox('auto_login_user');

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:todo_app/task_list_page.dart';
import 'login_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = '4oKZ1qhWH88IrupV9R56Q7dbG3FzYzZFCHsjeV7E';
  const keyClientKey = 'SC1UTdKNGFq9NaQkmYgANsOCsmTbiqvlFiCq6k6a';
  const keyParseServerUrl = 'https://parseapi.back4app.com';
  
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
    clientKey: keyClientKey, debug: true);

  runApp(MaterialApp(
    home: const LoginPage(),
    // home: const TaskViewPage(),
    theme: ThemeData(useMaterial3: false),
  ));
}

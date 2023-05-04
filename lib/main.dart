import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/screens/add_rule.dart';
import 'package:archivos_prueba/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FormVariableProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FormRuleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FormLiteralProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'save_file': (_) => const SaveFile(),
          'select_file': (context) => const SelectFile(),
          'mostrar': (context) => const Mostrar(),
          'home': (context) => const HomeScreen(),
          'add_variable': (context) => const AddVariable(),
          'menu': (context) => const MenuScreen(),
          'add_rule': (context) => const AddRule(),
        },
      ),
    );
  }
}

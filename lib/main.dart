import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'providers/article_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleProvider(),
      child: MaterialApp(
        title: 'Articles App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

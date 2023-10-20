import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    // current への変更を MyAppState に通知します
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  // どのウィジェットでも、そのウィジェットを常に最新にするために、周囲の状況が変化するたびに自動的に呼び出される build メソッドを定義します。
  Widget build(BuildContext context) {
    // watch メソッドを使用して、アプリの現在の状態に対する変更を追跡します。
    var appState = context.watch<MyAppState>();

    // どの build メソッドも必ずウィジェットか、ウィジェットのネストしたツリー（こちらの方が一般的）を返します。
    return Scaffold(
      // Column は、Flutterにおける非常に基本的なレイアウトウィジェットです。任意の数の子を従え、それらを上から下へ一列に配置します。
      body: Column(
        children: [
          Text('A random AWESOME idea:'),
          Text(appState.current.asLowerCase),
          ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next')),
        ],
      ),
    );
  }
}

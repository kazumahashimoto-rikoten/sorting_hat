import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sorting_hat/question_screen.dart';

final helloWorldProvider = Provider((_) => 'Hello world'); //プロバイダにクラスを入れることもできる
//複数指定できる
final favProvider = Provider((ref) => [
      '外に出ることが好き',
      'みんなとワイワイするのが好き',
      'まとめることが好き',
      'パソコンを触ることが好き',
      'お金の管理が好き',
      'おしゃべりするのが好き',
    ]);
final countryProvider = Provider((ref) => 'England');

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends HookConsumerWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text('hoge'),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionScreen(),
                    ));
              },
              child: Text(ref.watch(helloWorldProvider))),
        ));
  }
}

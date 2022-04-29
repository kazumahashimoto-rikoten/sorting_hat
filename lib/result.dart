import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sorting_hat/questions.dart';

class Result extends HookConsumerWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('診断結果'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              Text('あなたにおすすめの局は・・・'),
              Text('情報局です'),
              ElevatedButton(
                  onPressed: () {
                    ref.refresh(quesProvider);
                    // print(ref.watch(quesProvider)['other_questions']);
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Text('トップに戻る')),
            ],
          ),
        ),
      ),
    );
  }
}

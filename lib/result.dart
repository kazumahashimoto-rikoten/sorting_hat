import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sorting_hat/questions.dart';

class Result extends HookConsumerWidget {
  Result(this.department);
  final String department;
  final department_map = {
    "joho": "情報",
    "somu": "総務",
    "zaimu": "財務",
    "kikaku": "企画",
    "koho": "広報",
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final department_ja = department_map[department];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('診断結果'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'あなたにおすすめの局は・・・',
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              Text(
                '${department_ja}局です',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Stack(
                alignment: Alignment(-0.46, -0.48),
                children: [
                  Image.asset('images/22529281.jpg'),
                  Text(
                    department_ja!.split('').join('\n'),
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreenAccent),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  ref.refresh(quesProvider);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('トップに戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

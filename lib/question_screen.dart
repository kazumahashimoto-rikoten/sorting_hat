import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sorting_hat/result.dart';
// import 'package:sorting_hat/questions.dart';
import 'package:flutter/services.dart';
// import 'dart:math' as math;

import 'decision_tree.dart';

final ansProvider = Provider((ref) => []);
final quesProvider = Provider((ref) => []);

// ignore: must_be_immutable
class QuestionScreen extends HookConsumerWidget {
  QuestionScreen({Key? key}) : super(key: key);
  Map score = {"joho": 0, "somu": 0, "zaimu": 0, "kikaku": 0, "koho": 0};
  final allquesions = quesions();
  List<int> answers = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i = useState(0);
    // var currentQuestion = {};
    // int? maxValue;
    // String maxKey = '';

    // allquesions.then((value) {
    //   print(value);
    // }); //thenの中に書くと処理が終わってから実行される

    return WillPopScope(
      onWillPop: () async => false, //スワイプで戻れないように
      child: Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment.center,
            width: 250,
            height: 300,
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(
                      top: 4, bottom: 6, left: 4, right: 4),
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.lime.shade400,
                      padding: const EdgeInsets.all(5),
                      width: 250,
                      height: 190,
                      // child: selectQuestion,
                      child: FutureBuilder(
                        future: allquesions,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<String>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          var question = snapshot.data!.elementAt(i.value);
                          ref.watch(quesProvider).add(question);
                          return Text(question);
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      width: 100,
                      height: 90,
                      child: ElevatedButton(
                        onPressed: () {
                          onPressedCulc(i, ref, context, 1);
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.redAccent,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side: const BorderSide(
                              color: Colors.redAccent,
                              width: 3,
                            )),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.all(4),
                      width: 100,
                      height: 90,
                      child: ElevatedButton(
                        onPressed: () {
                          onPressedCulc(i, ref, context, 0);
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.blueAccent,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: const BorderSide(
                            color: Colors.blueAccent,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressedCulc(
      ValueNotifier<int> i, WidgetRef ref, BuildContext context, int isYes) {
    ref.watch(ansProvider).add(isYes);
    if (i.value == 6) {
      print(ref.watch(quesProvider));
      print(ref.watch(ansProvider));
      HapticFeedback.heavyImpact();
      decisionTree().then((value) {
        print(value);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Result(value!)),
        );
      });
      ref.watch(quesProvider).clear();
      ref.watch(ansProvider).clear();
    } else {
      HapticFeedback.mediumImpact();
      i.value += 1;
    }
  }
}

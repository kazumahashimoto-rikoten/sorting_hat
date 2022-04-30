import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sorting_hat/result.dart';
import 'package:sorting_hat/questions.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class QuestionScreen extends HookConsumerWidget {
  QuestionScreen({Key? key}) : super(key: key);
  Map score = {"joho": 0, "somu": 0, "zaimu": 0, "kikaku": 0, "koho": 0};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i = useState(0);
    var currentQuestion;
    int? maxValue;
    String maxKey = '';

    var selectQuestion = (() {
      if (i.value == 0) {
        var fQuestions = ref.watch(quesProvider)['first_questions'];
        int qLength = fQuestions!.length;
        int random = math.Random().nextInt(qLength);
        currentQuestion = fQuestions[random];
        return Text(currentQuestion['question'].toString());
      } else if (i.value == 1) {
        var secQuestions = ref.watch(quesProvider)['second_questions'];
        int qLength = secQuestions!.length;
        int random = math.Random().nextInt(qLength);
        currentQuestion = secQuestions[random];
        return Text(currentQuestion['question'].toString());
      } else {
        var otherQuestions = ref.watch(quesProvider)['other_questions'];
        int qLength = otherQuestions!.length;
        int random = math.Random().nextInt(qLength);
        currentQuestion = otherQuestions[random];
        ref.read(quesProvider)['other_questions']!.removeAt(random);
        return Text(currentQuestion['question'].toString());
      }
    })();
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
                      child: selectQuestion,
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
                          onPressedCulc(i, currentQuestion, maxValue, maxKey,
                              context, true);
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
                          onPressedCulc(i, currentQuestion, maxValue, maxKey,
                              context, false);
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

  void onPressedCulc(ValueNotifier<int> i, currentQuestion, int? maxValue,
      String maxKey, BuildContext context, bool isYes) {
    if (i.value < 10) {
      currentQuestion['points'].forEach((String dept, int point) {
        score[dept] = isYes ? score[dept] + point : score[dept] - point;
      });
      i.value += 1;
      HapticFeedback.mediumImpact();
    } else {
      score.forEach((key, value) {
        if (maxValue == null || value > maxValue) {
          maxValue = value;
          maxKey = key;
        }
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Result(maxKey),
        ),
      );
    }
  }
}

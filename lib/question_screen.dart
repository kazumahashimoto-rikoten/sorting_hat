import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sorting_hat/result.dart';
import 'package:sorting_hat/questions.dart';
import 'dart:math' as math;

class QuestionScreen extends HookConsumerWidget {
  QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i = useState(0);

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
                  margin: EdgeInsets.only(top: 4, bottom: 6, left: 4, right: 4),
                  child: SizedBox(
                    width: 250,
                    height: 190,
                    child: (() {
                      if (i.value == 0) {
                        var fQuestions =
                            ref.watch(quesProvider)['first_questions'];
                        int qLength = fQuestions!.length;
                        int random = math.Random().nextInt(qLength);
                        return Text(fQuestions[random]['question'].toString());
                      } else if (i.value == 1) {
                        var secQuestions =
                            ref.watch(quesProvider)['second_questions'];
                        int qLength = secQuestions!.length;
                        int random = math.Random().nextInt(qLength);
                        return Text(
                            secQuestions[random]['question'].toString());
                      } else {
                        var otherQuestions =
                            ref.watch(quesProvider)['other_questions'];
                        int qLength = otherQuestions!.length;
                        int random = math.Random().nextInt(qLength);
                        var nextQ = otherQuestions[random]['question'];
                        ref
                            .read(quesProvider)['other_questions']!
                            .removeAt(random);

                        // print(ref.read(quesProvider)['other_questions']);
                        return Text(nextQ.toString());
                      }
                    })(), //Text(ref.watch(favProvider)[i.value]),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(4),
                      width: 100,
                      height: 90,
                      child: ElevatedButton(
                        onPressed: () {
                          if (i.value < 10) {
                            i.value += 1;
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Result(),
                                ));
                          }
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
                          if (i.value < 10) {
                            i.value += 1;
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Result(),
                                ));
                          }
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
                            )),
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
}

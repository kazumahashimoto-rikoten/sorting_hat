import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sorting_hat/main.dart';

class QuestionScreen extends HookConsumerWidget {
  QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i = useState(0);

    return Scaffold(
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
                  child: Text(ref.watch(favProvider)[i.value]),
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
                        if (i.value < ref.watch(favProvider).length - 1) {
                          i.value += 1;
                        } else {
                          i.value = 0;
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
                        if (i.value < ref.watch(favProvider).length - 1) {
                          i.value += 1;
                        } else {
                          i.value = 0;
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
    );
  }
}

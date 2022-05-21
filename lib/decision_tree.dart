import 'package:flutter/services.dart' show rootBundle;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_preprocessing/ml_preprocessing.dart';
import 'package:sorting_hat/question_screen.dart';

Future<DataFrame> departmentData() async {
  final rawCsvContent =
      await rootBundle.loadString('assets/datasets/Department.csv');
  return DataFrame.fromRawCsv(rawCsvContent);
}

Future<List<String>> quesions() async {
  DataFrame departmentCSV = await departmentData();
  final headers =
      departmentCSV.dropSeries(seriesNames: ['Name', 'Dept']).header.toList();
  headers.shuffle();
  final takenHeadrs = headers.take(10).toList();
  return Future<List<String>>.value(takenHeadrs);
}

Future<String?> decisionTree(WidgetRef ref) async {
  DataFrame departmentCSV = await departmentData();
  List ques = ref.watch(quesProvider);
  var seriesNames = departmentCSV.header
      .toList()
      .where((element) => !ques.contains(element) && element != 'Dept')
      .toList();
  print(seriesNames);
  final samples = departmentCSV.shuffle().dropSeries(seriesNames: seriesNames);

  String featureNames = 'Dept';
  final pipeline = Pipeline(samples, [
    encodeAsIntegerLabels(
      featureNames: [
        featureNames
      ], // Here we convert strings from 'Species' column into numbers
    ),
  ]);

  final processed = pipeline.process(samples);

  //文字と変更した数を把握するためのmap作る
  var nameSet = <String>{};
  for (var element in samples.rows) {
    String featureName = element.last;
    nameSet.add(featureName);
  }
  var indexSet = <int>{};
  for (var element in processed.rows) {
    int featurenum = element.last;
    indexSet.add(featurenum);
  }
  print(nameSet);
  print(indexSet);

  var map = {for (var v in indexSet) v: nameSet.elementAt(v)};
  print(map);
  //ここまで

  final classifier = DecisionTreeClassifier(
    processed,
    featureNames,
    minError: 0.4,
    minSamplesCount: 5,
    maxDepth: 5,
  );

  await clcAccuracy(processed, featureNames);
  final data = <Iterable>[
    ques,
    ref.watch(ansProvider),
  ];
  final testData = DataFrame(data);
  final prediction = classifier.predict(testData);

  print(prediction.toMatrix());
  final predictionP = classifier.predictProbabilities(testData);
  print(predictionP.toMatrix());
  return map[prediction.rows.first.first.toInt()];
}

Future<void> clcAccuracy(DataFrame processed, String featureNames) async {
  const numberOfFolds = 5;

  final validator = CrossValidator.kFold(
    processed,
    numberOfFolds: numberOfFolds,
  );

  // ignore: prefer_function_declarations_over_variables
  final createClassifier = (DataFrame processed) => DecisionTreeClassifier(
        processed,
        featureNames,
        minError: 0.4,
        minSamplesCount: 5,
        maxDepth: 5,
      );

  final scores = await validator.evaluate(
    createClassifier,
    MetricType.accuracy,
  );

  final accuracy = scores.mean();

  print('accuracy on k fold validation: ${accuracy.toStringAsFixed(2)}');
}

import 'package:flutter/services.dart' show rootBundle;
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_preprocessing/ml_preprocessing.dart';

Future<DataFrame> departmentData() async {
  final rawCsvContent =
      await rootBundle.loadString('assets/datasets/Department.csv');
  return DataFrame.fromRawCsv(rawCsvContent);
}

Future<List<String>> allQuesions() async {
  DataFrame departmentCSV = await departmentData();
  final headers =
      departmentCSV.dropSeries(seriesNames: ['Name', 'Dept']).header;
  return Future<List<String>>.value(headers.toList());
}

void decisionTree() async {
  DataFrame departmentCSV = await departmentData();
  final samples = departmentCSV
      .shuffle()
      .dropSeries(seriesNames: ['Name', 'Q5', 'Q6', 'Q7', 'Q8', 'Q9', 'Q10']);

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
    String featureName = element.elementAt(4);
    nameSet.add(featureName);
  }
  var indexSet = <int>{};
  for (var element in processed.rows) {
    int featurenum = element.elementAt(4);
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
    minError: 0.3,
    minSamplesCount: 5,
    maxDepth: 4,
  );

  await clcAccuracy(processed, featureNames);

  final data = <Iterable>[
    ['Q1', 'Q2', 'Q3', 'Q4'],
    [1, 0, 1, 0], //テストデータ
    [1, 1, 1, 0],
  ];
  final testData = DataFrame(data);
  final prediction = classifier.predict(testData);

  print(prediction.toMatrix());
  final predictionP = classifier.predictProbabilities(testData);
  print(predictionP.toMatrix());
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
        minError: 0.3,
        minSamplesCount: 5,
        maxDepth: 4,
      );

  final scores = await validator.evaluate(
    createClassifier,
    MetricType.accuracy,
  );

  final accuracy = scores.mean();

  print('accuracy on k fold validation: ${accuracy.toStringAsFixed(2)}');
}

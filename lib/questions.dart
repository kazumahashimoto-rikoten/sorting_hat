import 'package:hooks_riverpod/hooks_riverpod.dart';

var quesProvider = Provider((ref) => {
      'first_questions': [
        {
          'question': '家の中にいるより外に出かけるのが好き',
          'points': {
            'joho': -2,
            'zaimu': -1,
            'somu': 0,
            'kikaku': 2,
            'koho': 2,
          },
        },
        {
          'question': '普段から周りをまとめることが好き',
          'points': {
            'joho': 1,
            'zaimu': 1,
            'somu': 3,
            'kikaku': 1,
            'koho': 1,
          },
        },
      ],
      'second_questions': [
        {
          'question': 'みんなとワイワイするのが好き',
          'points': {
            'joho': 2,
            'zaimu': -1,
            'somu': 0,
            'kikaku': 3,
            'koho': 3,
          },
        },
        {
          'question': 'パソコンはよく使う方だ',
          'points': {
            'joho': 5,
            'zaimu': 3,
            'somu': 2,
            'kikaku': -2,
            'koho': -2,
          },
        },
      ],
      'other_questions': [
        {
          'question': 'ゲームすることが好き',
          'points': {
            'joho': 3,
            'zaimu': -2,
            'somu': -2,
            'kikaku': 2,
            'koho': 1,
          },
        },
        {
          'question': '新しいものは気になってしまう',
          'points': {'joho': 2, 'zaimu': 1, 'somu': 1, 'kikaku': 1, 'koho': 1},
        },
        {
          'question': '自分は短期集中型だ',
          'points': {'joho': 2, 'zaimu': 1, 'somu': 1, 'kikaku': 1, 'koho': 1},
        },
        {
          'question': 'サークルはマイペースで参加したい',
          'points': {'joho': 2, 'zaimu': 1, 'somu': 1, 'kikaku': 1, 'koho': 1},
        },
        {
          'question': 'みんなよりすごいことがしたい',
          'points': {'joho': 2, 'zaimu': 1, 'somu': 1, 'kikaku': 1, 'koho': 1},
        },
        {
          'question': 'ものを作ったり組み立てたりするのは好きな方だ',
          'points': {'joho': 2, 'zaimu': 1, 'somu': 1, 'kikaku': 1, 'koho': 1},
        },
        {
          'question': '自分はコツコツ頑張るタイプだ',
          'points': {'joho': 2, 'zaimu': 1, 'somu': 1, 'kikaku': 1, 'koho': 1},
        },
        {
          'question': '競争よりも協調を好む',
          'points': {'joho': 2, 'zaimu': 1, 'somu': 1, 'kikaku': 1, 'koho': 1},
        },
        {
          'question': 'Apple製品をこよなく愛す',
          'points': {'joho': 2, 'zaimu': 1, 'somu': 1, 'kikaku': 1, 'koho': 1},
        },
        {
          'question': 'まだまだ学校生活に不安がある',
          'points': {'joho': 2, 'zaimu': 1, 'somu': 1, 'kikaku': 1, 'koho': 1},
        },
      ]
    });

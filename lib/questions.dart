import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sorting_hat/question_screen.dart';

//複数指定できる
final favProvider = Provider((ref) => [
      '外に出ることが好き',
      'みんなとワイワイするのが好き',
      'まとめることが好き',
      'パソコンを触ることが好き',
      'お金の管理が好き',
      'おしゃべりするのが好き',
    ]);

var quesProvider = Provider((ref) => {
      'first_questions': [
        {
          'question': '外に出ることが好き',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
        {
          'question': 'まとめることが好き',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
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
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
        {
          'question': 'パソコンを触ることが好き',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
      ],
      'other_questions': [
        {
          'question': 'ゲームすることが好き',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
        {
          'question': '新しいものは気になってしまう',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
        {
          'question': '自分は短期集中型だ',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
        {
          'question': 'サークルはマイペースで参加したい',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
        {
          'question': 'みんなよりすごいことがしたい',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
        {
          'question': 'ものを作ったり、組み立てたりするのは好きな方だ',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
        {
          'question': '自分はコツコツ頑張るタイプだ',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
        {
          'question': '競争よりも協調を好む',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
        {
          'question': 'Apple製品をこよなく愛す',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
        {
          'question': 'まだまだ学校生活に不安がある',
          'points': {
            'joho': 2,
            'zaimu': 1,
            'somu': 1,
            'kikaku': 1,
            'koho': 1,
          },
        },
      ]
    });

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/question.dart';

const apiEndpoint = 'http://10.0.0.2:3000';

List<Question> parseQuestions(Map<String, dynamic> json) {
  final questionsJson = json['questions'] as List<dynamic>;
  return questionsJson
      .map((questionJson) => Question.fromJson(questionJson))
      .toList();
}

String getDifficultyString(Difficulty difficulty) {
  var diffStr = '';
  switch (difficulty) {
    case Difficulty.easy:
      diffStr = 'easy';
      break;
    case Difficulty.medium:
      diffStr = 'medium';
      break;
    case Difficulty.hard:
      diffStr = 'hard';
      break;
  }
  return diffStr;
}

// 問題の難易度を与えると、問題のリストを返す関数
Future<List<Question>> fetchQuestions(Difficulty difficulty) async {
  final diffStr = getDifficultyString(difficulty);
  try {
    final response = await http
        .get(Uri.parse('$apiEndpoint/questions/$diffStr'));
    // .timeout(const Duration(milliseconds: 100));
    debugPrint(response.body);
    if (response.statusCode == 200) {
      // リクエスト成功時
      debugPrint("y");
      return parseQuestions(jsonDecode(response.body));
    } else {
      debugPrint("n");
      throw Exception('データ取得に失敗しました');
    }
  } catch (e) {
    debugPrint(e.toString());;
    // TODO: サーバの代わりに仮の値を返す
    // TODO: バックエンドが実装できたら削除する
    return [
      Question.name(
          AnswerOption.B,
          'https://github.com/jajimajp/benesse_quiz_app/blob/main/question_images/question_sample.png?raw=true',
          'https://github.com/jajimajp/benesse_quiz_app/blob/main/question_images/explanation_sample.png?raw=true'),
      Question.name(AnswerOption.B, 'https://placehold.jp/150x150.png',
          'https://placehold.jp/150x150.png'),
    ];
    // throw Exception('データ取得に失敗しました');
  }
}

class ResultInfo {
  final int rank; // 順位
  final int total; // 総数

  ResultInfo({required this.rank, required this.total});

  factory ResultInfo.fromJson (Map<String, dynamic> json) {
    return ResultInfo(
      rank: json['rank'],
      total: json['total'],
    );
  }
}

ResultInfo parseResultInfo(Map<String, dynamic> json) {
  return ResultInfo.fromJson(json);
}

// 解いた問題の難易度と正答数を与えると、順位とユーザ総数を返す関数
Future<ResultInfo> postResult(Difficulty difficulty, int correctCount) async {
  final diffStr = getDifficultyString(difficulty);
  try {
    final result = await http.post(Uri.parse('$apiEndpoint/result'),
        headers: {
          'Content-Type': 'application/json',
        },
        // TODO: リクエストボディの型をバックエンドに合わせて変える必要がある
        body: jsonEncode(
            {'correctCount': correctCount, 'difficulty': diffStr}));
    if (result.statusCode == 200) {
      // 成功
      return parseResultInfo(jsonDecode(result.body));
    } else {
      // 失敗
      throw Exception('データ取得に失敗しました');
    }
  } catch(e) {
    // TODO: サーバの代わりに仮の値を返す
    // TODO: バックエンドが実装できたら削除する
    return ResultInfo(rank: 100, total: 10000);
    // throw Exception('データ取得に失敗しました');
  }
}
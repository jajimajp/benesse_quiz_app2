import 'dart:async';

import 'package:benesse_quiz_app2/model/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './difficultyList.dart';

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

class Quizresult extends StatefulWidget {
  const Quizresult(this.difficulty, this.score, {super.key});

  final Difficulty difficulty;
  final int score;

  @override
  State<Quizresult> createState() => _QuizresultState();
}

class Result {
  final int score;
  final int rank;
  final int total;

  Result(this.score, this.rank, this.total);
}

class _QuizresultState extends State<Quizresult> {
  // TODO
  final param = "1";

  late Future<int> rank;

  late Future<Result> futureResult;

  @override
  void initState()  {
    super.initState();
    futureResult = getData();
  }

  Future<void> pushData() async {
    final int score = widget.score;
    final diffStr = getDifficultyString(widget.difficulty);
    await FirebaseFirestore.instance
        .collection('questions')
        .doc(diffStr)
        .collection('score')
        .add({'correct_count': score});
  }

  Future<Result> getData() async {
    await pushData();
    final score = widget.score;
    final diffStr = getDifficultyString(widget.difficulty);
    final ScoreRef = FirebaseFirestore.instance
        .collection('questions')
        .doc(diffStr)
        .collection('score');
    final querSnapshot = await ScoreRef.get();
    final document = querSnapshot.docs; // ドキュメントのリストを取得
    int count = 0;
    var scores = [];
    for (var doc in document) {
      final data = doc.data();
      int value = data['correct_count'];
      scores.add(value);
      count += 1;
      // scores.add(value);
      // ドキュメントのデータを処理する
    }
    print(scores);
    print(count);
    scores.sort((a, b) => b.compareTo(a));
    print(scores);
    var ranking = 0;
    for (var i in scores) {
      if (i == score) {
        ranking += 1;
        break;
      } else {
        ranking += 1;
      }
    }
    print("rank: $ranking");
    print("count: $count");
    return Result(score, ranking, count);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureResult,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(backgroundColor: Colors.yellow);
          }
          if (snapshot.hasError) {
            throw Exception('データ取得に失敗しました');
          }
          final score = snapshot.data!.score;
          final total = snapshot.data!.total;
          final rank = snapshot.data!.rank;

          return Scaffold(
            backgroundColor: Colors.yellow,
            body: SafeArea(
              child: Column(children: [
                Container(
                  width: 400,
                  padding: EdgeInsets.only(left: 0),
                  child: const Text("Result",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      )),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                ///得点部分
                Container(
                  width: 400,
                  height: 400,

                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(left: 30, top: 50, right: 30, bottom: 50),
                  //padding: EdgeInsets.only(left:30,top: 50,right: 30,bottom:50),
                  //color: Color(0xFFFAEFD8),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAEFD8),
                    border: Border.all(
                      color: Color(0xFF806DA6),
                      width: 10,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                      child: Text(
                        "あなたの得点は" + score.toString() + "点！\n"
                            + "$total人中$rank位！",
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'KGB',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),

                ///トップページに戻る部分
                Container(
                  width: 300,
                  height: 100,

                  margin:
                      EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 0),
                  decoration: BoxDecoration(
                    color: Color(0xFF000000),
                    borderRadius: BorderRadius.circular(30),
                  ),

                  ///戻るボタン
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DifficultyListView()),
                      );
                    },
                    child: const Text(
                      "BACK",
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const StadiumBorder(),
                    ),
                  ),
                )
              ]),
            ),
          );
        });
  }
}

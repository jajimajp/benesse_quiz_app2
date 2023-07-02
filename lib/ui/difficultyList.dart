import 'package:flutter/material.dart';
import '../model/question.dart';
import './quiz.dart';

class DifficultyListView extends StatelessWidget {
  //final List<Movie> movieList = Movie.getMovies();

  final List difficultyList = [
    Difficulty.easy,
    Difficulty.medium,
    Difficulty.hard,
  ];

  String getDifficultyLabel(Difficulty diff) {
    switch(diff) {
      case Difficulty.easy:
        return "初級";
      case Difficulty.medium:
        return "中級";
      case Difficulty.hard:
        return "上級";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: difficultyList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                movieCard(difficultyList[index], context),
              ],
            );
          }),
    );
  }

  Widget movieCard(Difficulty difficulty, BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Text(
                      getDifficultyLabel(difficulty),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizApp(difficulty),
            ));
      },
    );
  }
}
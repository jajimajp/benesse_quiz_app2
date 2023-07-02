import 'package:flutter/material.dart';
import '../model/question.dart';
import './quiz.dart';
//
// class DifficultyListView1 extends StatelessWidget {
//   //final List<Movie> movieList = Movie.getMovies();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Quiz"),
//         backgroundColor: Colors.blueGrey.shade900,
//       ),
//       backgroundColor: Colors.blueGrey.shade900,
//       body: ListView.builder(
//           itemCount: difficultyList.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Stack(
//               children: [
//                 movieCard(difficultyList[index], context),
//               ],
//             );
//           }),
//     );
//   }
//
//   Widget movieCard(Difficulty difficulty, BuildContext context) {
//     return InkWell(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: 120,
//         child: Card(
//           color: Colors.black45,
//           child: Padding(
//             padding: const EdgeInsets.only(
//               top: 8.0,
//               bottom: 8.0,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       getDifficultyLabel(difficulty),
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 17.0,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       onTap: () async {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => QuizApp(difficulty),
//             ));
//       },
//     );
//   }
// }
//
//
class DifficultyListView extends StatelessWidget {
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

      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Container(
          //width: MediaQuery.of(context).size.width,
          //height: 120,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
              bottom: 50,
            ),
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width:400,
                      padding: EdgeInsets.only(left: 0),
                      child: const Text(
                          "難易度を選択",
                          textAlign: TextAlign.center,
                          style:TextStyle(
                            fontSize:30,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          )),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8D121),
                        borderRadius: BorderRadius.circular(30),
                      ),),
                    ///easy
                    GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QuizApp(Difficulty.easy)),
                          );
                        },
                        child:Container(
                          width: 400,
                          height: 180,
                          //child:Text("easy"),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/difficulty_easy.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          //child: Image.asset('assets/flag.png'),
                        )
                    ),
                    ///normal
                    GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QuizApp(Difficulty.medium)),
                          );
                        },
                        child:Container(
                          width: 400,
                          height: 180,
                          //child:Text("normal"),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/difficulty_normal.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          //child: Image.asset('assets/flag.png'),
                        )
                    ),
                    ///hard
                    GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QuizApp(Difficulty.hard)),
                          );
                        },
                        child:Container(
                          width: 400,
                          height: 180,
                          //child:Text("hard"),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/difficulty_hard.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          //child: Image.asset('assets/flag.png'),
                        )
                    )

                  ],
                )
            ),
          ),

        ),
      ),
    );
  }
}
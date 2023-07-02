import 'package:flutter/material.dart';
import '../ui/difficultyList.dart';

class Quizresult extends StatelessWidget{
  final String param;
  const Quizresult({super.key, required this.param});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Result",
            style:TextStyle(
              fontSize:40,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            )),
        centerTitle: true,
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder( ///形変える
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),),
      ),
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Column(
            children:[
              ///得点部分
              Container(
                width: 400,
                height: 500,

                alignment: Alignment.center,
                margin: EdgeInsets.only(left:30,top: 50,right: 30,bottom: 50),
                //padding: EdgeInsets.only(left:30,top: 50,right: 30,bottom:50),
                //color: Color(0xFFFAEFD8),
                decoration: BoxDecoration(
                  color: Color(0xFFFAEFD8),
                  border: Border.all(
                    color:Color(0xFF806DA6),
                    width:10,
                  ),

                  borderRadius: BorderRadius.circular(30),
                ),
                child:Container(
                    child:Text(
                      "あなたの得点は"+param+"点！",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'KGB',
                        color: Colors.black,

                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              ///トップページに戻る部分
              Container(
                width: 300,
                height: 30,

                margin: EdgeInsets.only(left:30,top: 0,right: 30,bottom: 0),
                decoration: BoxDecoration(
                  color: Color(0xFF000000),
                  borderRadius: BorderRadius.circular(30),

                ),
                ///戻るボタン
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DifficultyListView()),
                    );
                  },
                  child: const Text(
                    "Top",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

              )
            ]
        ),
      ),
    );
  }
}

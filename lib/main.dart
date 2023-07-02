import 'package:benesse_quiz_app2/ui/difficultyList.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    home: DifficultyListView(),
  ));
  // runApp(GetInfo());
}

class GetInfo extends StatefulWidget {
  @override
  _GetInfoState createState() => _GetInfoState();
}
class _GetInfoState extends State<GetInfo> {
  List values = [];
  String? aUrl;
  int retryAttempts = 0;
  Timer? retryTimer;
  @override
  void initState() {
    super.initState();
    // getDataWithRetry();
    getData();
  }
  @override
  void dispose() {
    retryTimer?.cancel();
    super.dispose();
  }
  
  Future<void> getData() async {
    final collectionRef = FirebaseFirestore.instance
        .collection('questions')
        .doc('easy')
        .collection('dataset');
    final querySnapshot = await collectionRef.get();
    final documents = querySnapshot.docs; // ドキュメントのリストを取得
    for (var doc in documents) {
      final data = doc.data();
      values.add(data);
      // ドキュメントのデータを処理する
    }
    print(values);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GetInfo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(aUrl ?? 'URLがありません'),
              Text(aUrl ?? 'データを取得中...'),
            ],
          ),
        ),
      ),
    );
  }
}
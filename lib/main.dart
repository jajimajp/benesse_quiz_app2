import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetInfo());
}

class GetInfo extends StatefulWidget {
  @override
  _GetInfoState createState() => _GetInfoState();
}

class _GetInfoState extends State<GetInfo> {
  String? aUrl;
  int retryAttempts = 0;
  Timer? retryTimer;

  @override
  void initState() {
    super.initState();
    getDataWithRetry();
  }

  @override
  void dispose() {
    retryTimer?.cancel();
    super.dispose();
  }

  void getDataWithRetry() {
    retryTimer?.cancel();
    retryTimer = Timer(Duration(seconds: 2 * retryAttempts), () {
      getData();
    });
  }

  Future<void> getData() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('questions')
        .doc('easy')
        .collection('dataset')
        .doc('test')
        .get();

    if (docSnapshot != null && docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('a_url')) {
        setState(() {
          aUrl = data['a_url'];
        });
      } else {
        print('a_url not found');
      }
    } else {
      print('not exist');
    }

    if (aUrl == null) {
      retryAttempts++;
      getDataWithRetry();
    }
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
              // Image.network(aUrl ?? 'URLがありません'),
              Text(aUrl ?? 'データを取得中...'),
            ],
          ),

        ),
      ),
    );
  }
}
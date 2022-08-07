import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FingerPointingPage(),
    );
  }
}

class FingerPointingPage extends StatefulWidget {
  const FingerPointingPage({Key? key}) : super(key: key);

  @override
  State<FingerPointingPage> createState() => _FingerPointingPageState();
}

class _FingerPointingPageState extends State<FingerPointingPage> {
  String myArrow = '';
  String computerArrow = '';
  int result = 0;
  int topScore = 0;
  bool check = true;

  void selectArrow(String selectedArrow) {
    if (check) {
      myArrow = selectedArrow;
      print(myArrow);
      generateComputerArrow();
      judge();
      setState(() {});
    }
  }

  void generateComputerArrow() {
    final randomNumber = Random().nextInt(4);

    computerArrow = randomNumberToArrow(randomNumber);
  }

  String randomNumberToArrow(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return '↑';
      case 1:
        return '↓';
      case 2:
        return '←';
      case 3:
        return '→';
      default:
        return '↑';
    }
  }

  void judge() {
    if (myArrow == computerArrow) {
      print("自分：${myArrow}, 相手：${computerArrow}  回避失敗");
      check = false;
    } else {
      print("自分：${myArrow}, 相手：${computerArrow}  回避成功");
      result++;
    }
    if (result > topScore) {
      topScore = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('あっち向いてホイ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "最高記録：${topScore}",
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 48),
            Text(
              "連続回避数：${result}",
              style: TextStyle(fontSize: 27),
            ),
            SizedBox(height: 16),
            Text(
              "コンピューターが差した向き",
              style: TextStyle(fontSize: 27),
            ),
            Text(
              computerArrow,
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 48),
            Text(
              "自分の顔の向き",
              style: TextStyle(fontSize: 27),
            ),
            Text(
              myArrow,
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectArrow('↑');
                  },
                  child: Text('↑'),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectArrow('↓');
                  },
                  child: Text('↓'),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectArrow('←');
                  },
                  child: Text('←'),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectArrow('→');
                  },
                  child: Text('→'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    result = 0;
                    topScore = 0;
                    check = true;
                    setState(() {});
                  },
                  child: Text('リセット'),
                ),
                ElevatedButton(
                  onPressed: () {
                    result = 0;
                    check = true;
                    setState(() {});
                  },
                  child: Text('もう一度挑戦する'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

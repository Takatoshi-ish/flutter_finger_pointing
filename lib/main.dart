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
      title: 'Finger Pointing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FingerPointingPage(),
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
  bool continuationCheck = true; //ゲームが続いているかチェック

  void selectArrow(String selectedArrow) {
    if (continuationCheck) {
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
      print('自分：$myArrow, 相手：$computerArrow  回避失敗');
      continuationCheck = false;
    } else {
      print('自分：$myArrow, 相手：$computerArrow  回避成功');
      result++;
    }
    if (result > topScore) {
      topScore = result;
    }
  }

  void resetGame() {
    result = 0;
    topScore = 0;
    continuationCheck = true;
    setState(() {});
  }

  void againGame() {
    result = 0;
    continuationCheck = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('あっち向いてホイ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '最高記録：$topScore',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 48),
            Text(
              '連続回避数：$result',
              style: const TextStyle(fontSize: 27),
            ),
            const SizedBox(height: 16),
            const Text(
              'コンピューターが差した向き',
              style: TextStyle(fontSize: 27),
            ),
            Text(
              computerArrow,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 48),
            const Text(
              '自分の顔の向き',
              style: TextStyle(fontSize: 27),
            ),
            Text(
              myArrow,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: continuationCheck
                      ? () {
                          selectArrow('↑');
                        }
                      : null,
                  child: const Text('↑'),
                ),
                ElevatedButton(
                  onPressed: continuationCheck
                      ? () {
                          selectArrow('↓');
                        }
                      : null,
                  child: const Text('↓'),
                ),
                ElevatedButton(
                  onPressed: continuationCheck
                      ? () {
                          selectArrow('←');
                        }
                      : null,
                  child: const Text('←'),
                ),
                ElevatedButton(
                  onPressed: continuationCheck
                      ? () {
                          selectArrow('→');
                        }
                      : null,
                  child: const Text('→'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    resetGame();
                  },
                  child: const Text('リセット'),
                ),
                ElevatedButton(
                  onPressed: continuationCheck
                      ? null
                      : () {
                          againGame();
                        },
                  child: const Text('もう一度挑戦する'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

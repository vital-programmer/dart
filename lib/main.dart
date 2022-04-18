import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _maxValue = 1000;
  int _result = 1;
  int _answer1 = 1;
  int _answer2 = 2;
  int _answer3 = 3;
  int _count = 0;
  String _operation = '+1';

  void OnAnswerPressed(int buttonIndex) {
    String op = _operation[0];
    int other = int.parse(_operation.substring(1));
    int curRes = _result;
    int correct = 0;
    switch(buttonIndex) {
      case 1:
        correct = _answer1;
        break;
      case 2:
        correct = _answer2;
        break;
      default:
        correct = _answer3;
        break;
    }

    switch(op)
    {
      case "+":
        curRes += other;
        break;
      case "-":
        curRes -= other;
        break;
      case "/":
        curRes ~/= other;
        break;
      case "*":
        curRes *= other;
        break;
    }
    if (curRes == correct) {
      print('correct');
      setState(() {
        _count++;
        GetNewSum(correct);
      });
    }
    else {
      print('fail');
      setState(() {
        _count -= 3;
      });
    }
  }

  void GetNewSum(int res) {
    _result = res;
    var rnd = Random();
    String newOp = "";
    int opIndex = rnd.nextInt(4);
    int maxValue = 0;
    switch(opIndex){
      case 0:
        newOp += "+";
        maxValue = _maxValue - res;
        break;
      case 1:
        newOp += "-";
        maxValue = res;
        break;
      case 2:
        newOp += "/";
        maxValue = res;
        break;
      default:
        newOp += "*";
        maxValue = _maxValue ~/ res;
        break;
    }
    newOp += rnd.nextInt(maxValue).toString();
    if (newOp == '/0') {
      newOp = '/1';
    }
    if (newOp == '*0') {
      newOp = '*1';
    }
    setState(() {
      _operation = newOp;
    });
    String op = _operation[0];
    int other = int.parse(_operation.substring(1));
    switch(op)
    {
      case "+":
        res += other;
        break;
      case "-":
        res -= other;
        break;
      case "/":
        res ~/= other;
        break;
      case "*":
        res *= other;
        break;
    }
    setState(() {
      int index = rnd.nextInt(3);
      switch(index){
        case 0:
          _answer1 = res;
          _answer2 = rnd.nextInt(_maxValue);
          _answer3 = rnd.nextInt(_maxValue);
          break;
        case 1:
          _answer2 = res;
          _answer1 = rnd.nextInt(_maxValue);
          _answer3 = rnd.nextInt(_maxValue);
          break;
        default:
          _answer3 = res;
          _answer2 = rnd.nextInt(_maxValue);
          _answer1 = rnd.nextInt(_maxValue);
          break;
      }
    });
  }

  void ChangeDifficulty(int i) {
    int max = 0;
    switch(i){
      case 1:
        max = 20;
        break;
      case 2:
        max = 100;
        break;
      default:
        max = 1000;
        break;
    }
    setState(() {
      _maxValue = max;
    });
    GetNewSum(1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.pinkAccent,
        appBar: AppBar(
          title: Text("Hello World"),
          centerTitle: true,
          backgroundColor: Colors.black45,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\n$_count', style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontFamily: 'Times New Roman',
                ),),
                FloatingActionButton(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.black,
                    child: Text('$_answer1'),
                    onPressed: () {
                      OnAnswerPressed(1);
                    })
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FloatingActionButton(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black,
                        child: Text('E'),
                        onPressed: () {
                          ChangeDifficulty(1);
                        }),
                    FloatingActionButton(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black,
                        child: Text('M'),
                        onPressed: () {
                          ChangeDifficulty(2);
                        }),
                    FloatingActionButton(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black,
                        child: Text('H'),
                        onPressed: () {
                          ChangeDifficulty(3);
                        }),
                  ]
                ),
                Text('$_operation', style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),),
                FloatingActionButton(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black,
                    child: Text('$_result'),
                    onPressed: () {

                    }),
                FloatingActionButton(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black,
                    child: Text('$_answer2'),
                    onPressed: () {
                      OnAnswerPressed(2);
                    })
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    child: Text('$_answer3'),
                    onPressed: () {
                      OnAnswerPressed(3);
                    })
              ],
            ),
          ]
        ),
      ),
    );
  }
}
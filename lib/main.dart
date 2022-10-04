// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorting Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sorting Visualizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> corresponding = [
    9,
    8,
    7,
    6,
    5,
    4,
    2,
    9
  ]; //List.generate(5, (index) => Random().nextInt(9));
  String message = "Preparing Insertion Sort";
  int swapIndex1 = -1;
  int minIndex = -1;
  void selectionSort() async {
    var n = corresponding.length;
    for (var i = 0; i < n - 1; i++) {
      var index_min = i;
      setState(() {
        swapIndex1 = i;
        minIndex = i;
      });
      for (var j = i + 1; j < n - 1; j++) {
        if (corresponding[j] < corresponding[index_min]) {
          setState(() {
            minIndex = j;
          });
          index_min = j;
        }
      }
      if (index_min != i) {
        var temp = corresponding[i];
        setState(() {
          message =
              "Swapping ${corresponding[i]}  @index $i with the current minimum ${corresponding[index_min]} @index $index_min";
          corresponding[i] = corresponding[index_min];
          corresponding[index_min] = temp;
        });
      }
      await Future.delayed(Duration(seconds: 1), () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              selectionSort();
            },
            child: Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                corresponding = [9, 8, 7, 6, 5, 4, 2, 9];
              });
            },
            child: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var i = 0; i < corresponding.length - 1; i++)
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(corresponding[i].toString()),
                              Container(
                                height: 200 * ((corresponding[i]) / 10),
                                width: 40,
                                color: Colors.black,
                              ),
                              Visibility(
                                  visible: swapIndex1 == i || minIndex == i,
                                  child: Icon(Icons.arrow_circle_up_outlined))
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(message)
          ],
        ),
      ),
    );
  }
}

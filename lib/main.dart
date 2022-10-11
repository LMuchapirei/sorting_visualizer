// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, curly_braces_in_flow_control_structures

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
  List<int> corresponding = [9, 8, 7, 6, 5, 4, 2, 9];
  String selectedSort = "Selection Sort";
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

  void insertionSort() async {
    int n = corresponding.length;
    for (var i = 0; i < n; i++) {
      for (var j = i; j > 0; j--) {
        if (corresponding[j] < corresponding[j - 1]) {
          setState(() {
            message =
                "Swapping ${corresponding[j]}  @index $j and Swapping ${corresponding[j - 1]}  @index ${j - 1} ";
            var tmp = corresponding[j - 1];
            corresponding[j - 1] = corresponding[j];
            corresponding[j] = tmp;
          });
        }
        await Future.delayed(Duration(seconds: 1),
            () {}); // TODO: fix a bug when you place reset it continues to do the sorting
      }
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
              if (selectedSort == "Selection Sort") selectionSort();
              if (selectedSort == "Insertion Sort") insertionSort();
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
              'Select the visualizer you want',
            ),
            DropdownButton(
                items: [
                  DropdownMenuItem(
                    value: "Selection Sort",
                    child: Text("Selection Sort"),
                  ),
                  DropdownMenuItem(
                    value: "Insertion Sort",
                    child: Text("Insertion Sort"),
                  )
                ],
                value: selectedSort,
                onChanged: (val) {
                  setState(() {
                    selectedSort = val!;
                  });
                }),
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
                              if (selectedSort == "Selection Sort")
                                Column(
                                  children: [
                                    Container(
                                      height: 200 * ((corresponding[i]) / 10),
                                      width: 40,
                                      color: Colors.black,
                                    ),
                                    Visibility(
                                        visible:
                                            swapIndex1 == i || minIndex == i,
                                        child: Icon(
                                            Icons.arrow_circle_up_outlined))
                                  ],
                                ),
                              if (selectedSort == "Insertion Sort")
                                Container(
                                  height: 200 * (corresponding[i] / 10),
                                  width: 40,
                                  color: Colors.blue,
                                )
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

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int min = 1;
  int max = 6;

  List<int> values = [];

  @override
  Widget build(BuildContext context) {
    var snackBar = SnackBar(
      content: Text('Random number $min - $max'),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Randomize"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () =>
                  ScaffoldMessenger.of(context).showSnackBar(snackBar),
              icon: const Icon(
                Icons.door_back_door_outlined,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () => settings(context),
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ))
        ],
      ),
      body: Row(
        children: [
          Column(
            children: [
              const Text("List"),
              Column(
                children: [for (var value in values) Text("$value")],
              )
            ],
          ),
          Expanded(
              child: Center(
            child: FloatingActionButton(
                onPressed: () => addRandomNumber(), child: getDiceImage()),
          ))
        ],
      ),
    );
  }

  void addRandomNumber() {
    final random = Random();

    setState(() {
      values.add(random.nextInt(max - min + 1) + min);
    });
  }

  Widget getDiceImage() {
    int latestNumber = values.isEmpty ? 1 : values[values.length - 1];

    switch (latestNumber) {
      case 1:
        return Image.asset("assets/one.png");
      case 2:
        return Image.asset("assets/two.png");
      case 3:
        return Image.asset("assets/three.png");
      case 4:
        return Image.asset("assets/four.png");
      case 5:
        return Image.asset("assets/five.png");
      case 6:
        return Image.asset("assets/six.png");
      default:
        return Text("$latestNumber");
    }
  }

  Future<void> settings(BuildContext context) async {
    final data = await Navigator.pushNamed(context, "/settings",
        arguments: RangeValues(min.toDouble(), max.toDouble()));

    RangeValues test = data as RangeValues;

    setState(() {
      min = test.start.round();
      max = test.end.round();
    });

    print("$min $max");
  }
}

import 'package:calculator/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> buttons = [
    "AC",
    "DLT",
    "%",
    "/",
    "9",
    "8",
    "7",
    "*",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  var userinput = "";
  var useroutput = "";

  void expressions() {
    Parser p = Parser();
    Expression exp = p.parse(userinput);
    ContextModel cm = ContextModel();
    var eval = exp.evaluate(EvaluationType.REAL, cm);
    useroutput = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userinput,
                      style: const TextStyle(color: Colors.brown, fontSize: 25),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      useroutput,
                      style: const TextStyle(color: Colors.brown, fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: 350,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: buttons.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return AllButtons(
                        onPressed: () {
                          setState(() {
                            userinput = "";
                          });
                        },
                        buttoncolor: Colors.green,
                        buttontext: buttons[index],
                        buttontextcolor: Colors.black,
                      );
                    } else if (index == 1) {
                      return AllButtons(
                        onPressed: () {
                          setState(() {
                            userinput =
                                userinput.substring(0, userinput.length - 1);
                          });
                        },
                        buttoncolor: Colors.red,
                        buttontext: buttons[index],
                        buttontextcolor: Colors.black,
                      );
                    } else if (index == buttons.length - 1) {
                      return AllButtons(
                        onPressed: () {
                          setState(() {
                            expressions();
                          });
                        },
                        buttoncolor: Colors.yellow,
                        buttontext: buttons[index],
                        buttontextcolor: Colors.black,
                      );
                    } else {
                      return AllButtons(
                        onPressed: () {
                          setState(() {
                            userinput = userinput + buttons[index];
                          });
                        },
                        buttoncolor: isOperator(buttons[index])
                            ? Colors.yellow
                            : Colors.white,
                        buttontext: buttons[index],
                        buttontextcolor: Colors.black,
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "%" || x == "+" || x == "-" || x == "*" || x == "/" || x == "=") {
      return true;
    }
    return false;
  }
}

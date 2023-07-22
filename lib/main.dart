import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String equation = "0";
  String expression = "";
  double equationFontSize = 38.0;
  buttonPressed(String btnText) {
    setState(() {
      if (btnText == "AC") {
        equation = "0";
      } else if (btnText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (btnText == "=") {
        expression = equation;
        expression = equation.replaceAll("*", "*");
        expression = equation.replaceAll("/", "/");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          equation = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          equation = "Error";
        }
      } else {
        if (equation == "0") {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  Widget calcbutton(String btnText, Color btnColor, Color textColor) {
    return Container(
      child: ElevatedButton(
        onPressed: () => buttonPressed(btnText),
        child: Text(
          btnText,
          style: TextStyle(fontSize: 45, color: textColor),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(CircleBorder()),
          padding: MaterialStateProperty.all(EdgeInsets.all(10)),
          backgroundColor: MaterialStateProperty.all(btnColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Calculator"),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        equation,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 100),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton("AC", Colors.grey, Colors.black),
                  calcbutton("⌫", Colors.grey, Colors.black),
                  calcbutton("%", Colors.grey, Colors.black),
                  calcbutton("/", Colors.amber.shade700, Colors.white),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton("7", Colors.grey.shade800, Colors.white),
                  calcbutton("8", Colors.grey.shade800, Colors.white),
                  calcbutton("9", Colors.grey.shade800, Colors.white),
                  calcbutton("*", Colors.amber.shade700, Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton("4", Colors.grey.shade800, Colors.white),
                  calcbutton("5", Colors.grey.shade800, Colors.white),
                  calcbutton("6", Colors.grey.shade800, Colors.white),
                  calcbutton("-", Colors.amber.shade700, Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcbutton("1", Colors.grey.shade800, Colors.white),
                  calcbutton("2", Colors.grey.shade800, Colors.white),
                  calcbutton("3", Colors.grey.shade800, Colors.white),
                  calcbutton("+", Colors.amber.shade700, Colors.white),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.shade800,
                    ),
                    padding: EdgeInsets.fromLTRB(0, 1, 80, 1),
                    child: calcbutton("0", Colors.grey.shade800, Colors.white),
                  ),
                  calcbutton(".", Colors.grey.shade800, Colors.white),
                  calcbutton("=", Colors.amber.shade700, Colors.white),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

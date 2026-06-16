import 'package:math_expressions/math_expressions.dart';
import 'package:calculator_app/components/my_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables
  String userInput = "0";
  String result = "0";
  Color resultColor = Colors.black;
  double inputFontSize = 50;

  void buttonPressed(String value) {
    if (userInput.length >= 30) return;
      setState(() {
        if (result != "0") {
          userInput = result + value;
          result = "0";
          resultColor = Colors.black;
          inputFontSize = 50;
        } else if (userInput == "0") {
          userInput = value;
        } else {
          userInput += value;
        }
      });
  }

  void clearPressed() {
    setState(() {
      userInput = "0";
      result = "0";
    });
  }

  void backspacePressed() {
    setState(() {
      if (userInput.length <= 1) {
        userInput = "0";
      } else {
        userInput = userInput.substring(0, userInput.length - 1);
      }
    });
  }

  void toggleSign() {
  setState(() {
    if (userInput.startsWith("-")) {
        userInput = userInput.substring(1);
    } else {
        userInput = "-" + userInput;
      }
    });
  }

  void equalPressed() {
    setState(() {
      try {
        String exp1 = userInput.replaceAllMapped(
        RegExp(r'(\d+\.?\d*)%'),
        (match) => "(${match.group(1)}/100)",
      );
      String expression = exp1.replaceAll("x", "*").replaceAll("÷", "/");
      GrammarParser p = GrammarParser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      resultColor = Colors.green;
      inputFontSize = 30;
      result = eval % 1 == 0 ? eval.toInt().toString() : double.parse(eval.toStringAsFixed(10)).toString();
      } catch (e) {
          result = "Error";
          resultColor = Colors.red;
        }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Calculator"), 
        backgroundColor: Colors.green,
      ),
      body:
         Column(
           children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 9),
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: 
                    result == "0"
                    ? [Text(userInput, style: TextStyle(fontSize: 50))]
                    : [
                        Text(userInput, style: TextStyle(fontSize: 30, color: Colors.grey.shade500)),
                        Text(result, style: TextStyle(fontSize: 50, color: resultColor)),
                      ],            
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
                children: [
                  MyButton(text: "C", onTap: clearPressed, color: Colors.grey.shade400,),
                  MyButton(text: "⌫", onTap: backspacePressed, color: Colors.grey.shade400,),
                  MyButton(text: "%", onTap: () => buttonPressed("%"), color: Colors.grey.shade400,),
                  MyButton(text: "÷", onTap: () => buttonPressed("÷"), color: Colors.grey.shade700, textColor: Colors.white,),
                  MyButton(text: "7", onTap: () => buttonPressed("7"), color: Colors.grey.shade200,),
                  MyButton(text: "8", onTap: () => buttonPressed("8"), color: Colors.grey.shade200,),
                  MyButton(text: "9", onTap: () => buttonPressed("9"), color: Colors.grey.shade200,),
                  MyButton(text: "x", onTap: () => buttonPressed("x"), color: Colors.grey.shade700, textColor: Colors.white,),
                  MyButton(text: "4", onTap: () => buttonPressed("4"), color: Colors.grey.shade200,),
                  MyButton(text: "5", onTap: () => buttonPressed("5"), color: Colors.grey.shade200,),
                  MyButton(text: "6", onTap: () => buttonPressed("6"), color: Colors.grey.shade200,),
                  MyButton(text: "-", onTap: () => buttonPressed("-"), color: Colors.grey.shade700, textColor: Colors.white,),
                  MyButton(text: "1", onTap: () => buttonPressed("1"), color: Colors.grey.shade200,),
                  MyButton(text: "2", onTap: () => buttonPressed("2"), color: Colors.grey.shade200,),
                  MyButton(text: "3", onTap: () => buttonPressed("3"), color: Colors.grey.shade200,),
                  MyButton(text: "+", onTap: () => buttonPressed("+"), color: Colors.grey.shade700, textColor: Colors.white,),
                  MyButton(text: "+/-", onTap: () => toggleSign(), color: Colors.grey.shade200,),
                  MyButton(text: "0", onTap: () => buttonPressed("0"), color: Colors.grey.shade200,),
                  MyButton(text: ".", onTap: () => buttonPressed("."), color: Colors.grey.shade200,),
                  MyButton(text: "=", onTap: () => equalPressed(), color: Colors.green.shade600, textColor: Colors.white,),
                ],
              ),
           ],
         ),
    );
  }
}
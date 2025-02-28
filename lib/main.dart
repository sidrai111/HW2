import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '';
      } else if (value == '=') {
        try {
          result = _evaluateExpression(input);
        } catch (e) {
          result = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      List<String> tokens = expression.split(RegExp(r'([+\-*/])'));
      if (tokens.length != 3) return 'Error';
      double num1 = double.parse(tokens[0]);
      double num2 = double.parse(tokens[2]);
      String operator = tokens[1];
      double output;

      switch (operator) {
        case '+':
          output = num1 + num2;
          break;
        case '-':
          output = num1 - num2;
          break;
        case '*':
          output = num1 * num2;
          break;
        case '/':
          if (num2 == 0) return 'Error';
          output = num1 / num2;
          break;
        default:
          return 'Error';
      }
      return output.toString();
    } catch (e) {
      return 'Error';
    }
  }

  Widget buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onButtonPressed(text),
        child: Text(text, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CalculatorApp')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                input + (result.isNotEmpty ? ' = $result' : ''),
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          Column(
            children: [
              ['7', '8', '9', '/'],
              ['4', '5', '6', '*'],
              ['1', '2', '3', '-'],
              ['C', '0', '=', '+'],
            ].map((row) {
              return Row(
                children: row.map((text) => buildButton(text)).toList(),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

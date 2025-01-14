import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0"; // Displays the output or result
  String _input = ""; // Keeps track of the full equation
  double? _num1; // Stores the first operand
  String? _operator; // Stores the current operator

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        // Reset all values
        _output = "0";
        _input = "";
        _num1 = null;
        _operator = null;
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (_num1 == null && _input.isNotEmpty) {
          // First operand and operator
          _num1 = double.tryParse(_input);
          _operator = value;
          _input += value;
        }
      } else if (value == "=") {
        if (_num1 != null && _operator != null && _input.isNotEmpty) {
          // Parse the second number
          String secondNumberString = _input.split(_operator!)[1];
          double? _num2 = double.tryParse(secondNumberString);

          if (_num2 != null) {
            // Perform calculation based on the operator
            double result;
            switch (_operator) {
              case "+":
                result = _num1! + _num2;
                break;
              case "-":
                result = _num1! - _num2;
                break;
              case "*":
                result = _num1! * _num2;
                break;
              case "/":
                result = _num2 != 0 ? _num1! / _num2 : double.nan;
                break;
              default:
                result = 0;
            }

            _output = result.toString();
          } else {
            _output = "Error";
          }
        }
      } else {
        // Append numbers to the input string
        _input += value;
        _output = _input;
      }
    });
  }

  Widget buildButton(String value, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0),
          ),
          onPressed: () => buttonPressed(value),
          child: Text(
            value,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // Display Area
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 8.0,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider()),
          // Buttons Grid
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("7", Colors.blue[100]!),
                  buildButton("8", Colors.blue[100]!),
                  buildButton("9", Colors.blue[100]!),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4", Colors.blue[100]!),
                  buildButton("5", Colors.blue[100]!),
                  buildButton("6", Colors.blue[100]!),
                  buildButton("*", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1", Colors.blue[100]!),
                  buildButton("2", Colors.blue[100]!),
                  buildButton("3", Colors.blue[100]!),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("C", Colors.red),
                  buildButton("0", Colors.blue[100]!),
                  buildButton("=", Colors.green),
                  buildButton("+", Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

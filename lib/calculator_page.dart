import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _result = "0";
  String _operand = "";
  double _num1 = 0.0;
  double _num2 = 0.0;
  bool _isResultDisplayed = false;

  void _buttonPressed(String buttonText) {
    if (buttonText == "AC") {
      _output = "0";
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
      _isResultDisplayed = false;
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      _num1 = double.parse(_output);
      _operand = buttonText;
      _output = "0";
      _isResultDisplayed = false;
    } else if (buttonText == ".") {
      if (!_output.contains(".")) {
        _output += buttonText;
      }
      _isResultDisplayed = false;
    } else if (buttonText == "=") {
      _num2 = double.parse(_output);
      if (_operand == "+") {
        _result = (_num1 + _num2).toString();
      }
      if (_operand == "-") {
        _result = (_num1 - _num2).toString();
      }
      if (_operand == "*") {
        _result = (_num1 * _num2).toString();
      }
      if (_operand == "/") {
        _result = (_num1 / _num2).toString();
      }
      _output = _formatResult(_result);
      _operand = "";
      _isResultDisplayed = true;
    } else if (buttonText == "√") {
      _num1 = double.parse(_output);
      _result = sqrt(_num1).toString();
      _output = _formatResult(_result);
      _isResultDisplayed = true;
    } else if (buttonText == "DEL") {
      if (_output.length > 1) {
        _output = _output.substring(0, _output.length - 1);
      } else {
        _output = "0";
      }
      _isResultDisplayed = false;
    } else {
      if (_isResultDisplayed) {
        _output = buttonText;
        _isResultDisplayed = false;
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    }

    setState(() {
      _output = _formatResult(_output);
    });
  }

  String _formatResult(String result) {
    if (result.contains(".")) {
      List<String> parts = result.split(".");
      if (parts.length > 1 && parts[1] == "0") {
        return parts[0];
      }
    }
    return result;
  }

  Widget buildButton(String buttonText, {Color color = const Color.fromARGB(137, 54, 54, 54)}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            backgroundColor: color,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text(buttonText),
          onPressed: () => _buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Expanded(
            child: Divider(color: Colors.black),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("AC", color: const Color.fromARGB(255, 153, 152, 152)),
                  buildButton("<--", color: const Color.fromARGB(255, 150, 149, 149)),
                  buildButton("√", color: const Color.fromARGB(255, 150, 150, 150)),
                  buildButton("/", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("*", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("-", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: buildButton("0"),
                  ),
                  buildButton("."),
                  buildButton("=", color: Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

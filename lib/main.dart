import 'package:flutter/material.dart';
import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(ScientificCalculatorApp());
}

class ScientificCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: ScientificCalculator(),
    );
  }
}

class ScientificCalculator extends StatefulWidget {
  @override
  _ScientificCalculatorState createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  String _output = "";
  String _input = "";
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      setState(() {
        _input = "";
        _output = "";
      });
    } else if (buttonText == "=") {
      try {
        Parser p = Parser();
        Expression exp = p.parse(_input);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        setState(() {
          _output = eval.toStringAsFixed(2);
        });
      } catch (e) {
        setState(() {
          _output = "Error";
        });
      }
    } else if (buttonText == "sin") {
      _calculateSin();
    } else if (buttonText == "cos") {
      _calculateCos();
    } else if (buttonText == "tan") {
      _calculateTan();
    } else if (buttonText == "cot") {
      _calculateCot();
    } else {
      setState(() {
        _input += buttonText;
      });
    }
  }

  void _calculateSin() {
    try {
      double inputValue = double.parse(_input);
      double result = sin(inputValue);
      setState(() {
        _output = result.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        _output = "Error";
      });
    }
  }

  void _calculateCos() {
    try {
      double inputValue = double.parse(_input);
      double result = cos(inputValue);
      setState(() {
        _output = result.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        _output = "Error";
      });
    }
  }

  void _calculateTan() {
    try {
      double inputValue = double.parse(_input);
      double result = tan(inputValue);
      setState(() {
        _output = result.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        _output = "Error";
      });
    }
  }

  void _calculateCot() {
    try {
      double inputValue = double.parse(_input);
      double result = 1.0 / tan(inputValue);
      setState(() {
        _output = result.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        _output = "Error";
      });
    }
  }

  Widget _buildButton(String buttonText,
      {Color color = Colors.blueGrey, Color textColor = Colors.white}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
            padding: EdgeInsets.all(20.0),
            textStyle: TextStyle(fontSize: 24.0, color: textColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora Científica",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Text(
              _input,
              style: TextStyle(fontSize: 28.0, color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton("sin", textColor: Colors.white),
              _buildButton("cos", textColor: Colors.white),
              _buildButton("tan", textColor: Colors.white),
              _buildButton("cot", textColor: Colors.white),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("7", textColor: Colors.black),
              _buildButton("8", textColor: Colors.black),
              _buildButton("9", textColor: Colors.black),
              _buildButton("/", textColor: Colors.white),
              _buildButton("sqrt", textColor: Colors.white),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("4", textColor: Colors.black),
              _buildButton("5", textColor: Colors.black),
              _buildButton("6", textColor: Colors.black),
              _buildButton("*", textColor: Colors.white),
              _buildButton("ln", textColor: Colors.white),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("1", textColor: Colors.black),
              _buildButton("2", textColor: Colors.black),
              _buildButton("3", textColor: Colors.black),
              _buildButton("-", textColor: Colors.white),
              _buildButton("(", textColor: Colors.white),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("0", textColor: Colors.black),
              _buildButton(".", textColor: Colors.black),
              _buildButton("C", textColor: Colors.white, color: Colors.red),
              _buildButton("+", textColor: Colors.white),
              _buildButton(")", textColor: Colors.white),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton("^", textColor: Colors.white),
              _buildButton("=", textColor: Colors.black, color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }
}

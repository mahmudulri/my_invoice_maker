import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _output = '0';
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
        _num1 = double.tryParse(_output) ?? 0;
        _operator = value;
        _output = '0';
      } else if (value == '=') {
        _num2 = double.tryParse(_output) ?? 0;
        switch (_operator) {
          case '+':
            _output = (_num1 + _num2).toString();
            break;
          case '-':
            _output = (_num1 - _num2).toString();
            break;
          case '×':
            _output = (_num1 * _num2).toString();
            break;
          case '÷':
            _output = _num2 != 0 ? (_num1 / _num2).toString() : 'Error';
            break;
        }
        _operator = '';
      } else {
        if (_output == '0') {
          _output = value;
        } else {
          _output += value;
        }
      }
    });
  }

  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () => _buttonPressed(label),
      child: Text(label, style: TextStyle(fontSize: 15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(_output, style: TextStyle(fontSize: 24)),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var label in [
                '7',
                '8',
                '9',
                '÷',
                '4',
                '5',
                '6',
                '×',
                '1',
                '2',
                '3',
                '-',
                'C',
                '0',
                '=',
                '+'
              ])
                SizedBox(
                  width: 70,
                  child: _buildButton(label),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

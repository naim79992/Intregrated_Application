import 'package:flutter/material.dart';

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});

  @override
  _UnitConverterScreenState createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  String _input = '';
  String _output = '';
  String _selectedConversion = 'Weight';
  String _fromUnit = 'kg';
  String _toUnit = 'lb';

  final Map<String, List<String>> _units = {
    'Weight': ['kg', 'lb', 'g'],
    'Temperature': ['C', 'F', 'K']
  };

  final Map<String, Map<String, double>> _conversionFactors = {
    'Weight': {
      'kg_to_lb': 2.20462,
      'kg_to_g': 1000,
      'lb_to_kg': 0.453592,
      'lb_to_g': 453.592,
      'g_to_kg': 0.001,
      'g_to_lb': 0.00220462,
    },
    'Temperature': {
      'C_to_F': 1.8,
      'F_to_C': -0.555556,
      'C_to_K': 1,
      'K_to_C': 1,
      'F_to_K': 0.555556,
      'K_to_F': -1.8,
    }
  };

  void _convert() {
    setState(() {
      if (_input.isNotEmpty) {
        double value = double.parse(_input);
        if (_selectedConversion == 'Weight') {
          _output = _convertWeight(value).toStringAsFixed(2);
        } else if (_selectedConversion == 'Temperature') {
          _output = _convertTemperature(value).toStringAsFixed(2);
        }
      }
    });
  }

  double _convertWeight(double value) {
    String key = '${_fromUnit}_to_$_toUnit';
    return value * (_conversionFactors['Weight']![key] ?? 1);
  }

  double _convertTemperature(double value) {
    if (_fromUnit == 'C' && _toUnit == 'F') {
      return (value * _conversionFactors['Temperature']!['C_to_F']!) + 32;
    } else if (_fromUnit == 'F' && _toUnit == 'C') {
      return (value - 32) * _conversionFactors['Temperature']!['F_to_C']!;
    } else if (_fromUnit == 'C' && _toUnit == 'K') {
      return value + 273.15;
    } else if (_fromUnit == 'K' && _toUnit == 'C') {
      return value - 273.15;
    } else if (_fromUnit == 'F' && _toUnit == 'K') {
      return (value - 32) * _conversionFactors['Temperature']!['F_to_K']! +
          273.15;
    } else if (_fromUnit == 'K' && _toUnit == 'F') {
      return (value - 273.15) * _conversionFactors['Temperature']!['K_to_F']! +
          32;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedConversion,
              onChanged: (value) {
                setState(() {
                  _selectedConversion = value!;
                  _fromUnit = _units[_selectedConversion]![0];
                  _toUnit = _units[_selectedConversion]![1];
                });
              },
              items: _units.keys.map<DropdownMenuItem<String>>((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _fromUnit,
              onChanged: (value) {
                setState(() {
                  _fromUnit = value!;
                });
              },
              items: _units[_selectedConversion]!
                  .map<DropdownMenuItem<String>>((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _toUnit,
              onChanged: (value) {
                setState(() {
                  _toUnit = value!;
                });
              },
              items: _units[_selectedConversion]!
                  .map<DropdownMenuItem<String>>((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter value',
              ),
              onChanged: (value) {
                _input = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              _output,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

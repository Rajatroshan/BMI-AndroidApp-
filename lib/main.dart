import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BmiCalculator(),
    );
  }
}

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmiResult = 0.0;

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double height = double.tryParse(heightController.text) ?? 0.0;
    if (weight > 0 && height > 0) {
      setState(() {
        bmiResult = weight / ((height / 100) * (height / 100));
      });
    }
  }

  Color getBackgroundColor() {
    if (bmiResult < 18.5) {
      return Colors.red; // Underweight
    } else if (bmiResult >= 18.5 && bmiResult <= 24.9) {
      return Colors.green; // Normal weight
    } else {
      return Colors.orange; // Overweight
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = getBackgroundColor();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey, // Custom background color for app bar
        title: const Text(
          "BMI Calculator",
          style: TextStyle(color: Colors.white), // Custom text color for app bar title
        ),
        centerTitle: true, // Align title text to center
        actions: [
          IconButton(
            onPressed: () {
              // Add any action you want here
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: 'Enter Weight (kg)',
                prefixIcon: Icon(Icons.line_weight),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(
                labelText: 'Enter Height (cm)',
                prefixIcon: Icon(Icons.height),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calculateBMI,
              child: const Text('Calculate BMI'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'BMI: ${bmiResult.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

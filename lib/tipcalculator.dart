import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key});

  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  final _formKey = GlobalKey<FormState>();
  double _billAmount = 0.0;
  double _tipPercentage = 15.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Bill Amount',
                ),
                validator: (value) {
                  if (value == '') {
                    return 'Please enter the bill amount';
                  }
                  if (double.tryParse(value!) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _billAmount = double.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Tip Percentage',
                ),
                validator: (value) {
                  if (value == '') {
                    return 'Please enter the tip percentage';
                  }
                  if (double.tryParse(value!) == null ||
                      double.parse(value) <= 0 ||
                      double.parse(value) > 100) {
                    return 'Please enter a valid percentage between 0 and 100';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tipPercentage = double.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculateTotal,
                child: const Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calculateTotal() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      double tipAmount = _billAmount * (_tipPercentage / 100);
      double totalAmount = _billAmount + tipAmount;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Total Amount'),
          content: Text('Total Tip Amount Rs: ${tipAmount.toStringAsFixed(2)} '
              ' Total amount to be paid: Rs:${totalAmount.toStringAsFixed(2)}'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

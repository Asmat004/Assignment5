import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key});

  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  double totalTip = 0;
  double totalBill = 0.0;
  TextEditingController billController = TextEditingController();
  TextEditingController tipController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tip Calculator")),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(children: [
              Text("Total Tip: $totalTip"),
              Text("Total Bill after calculating Tip: $totalBill"),
              TextFormField(
                controller: billController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Bill Amount should not be Empty');
                  } else {
                    return null;
                  }
                },
                decoration:
                    const InputDecoration(hintText: "Enter Bill Amount"),
              ),
              TextFormField(
                controller: tipController,
                validator: (value) {
                  if (value == '') {
                    return 'Tip Amount should not be empty';
                  } else {
                    return null;
                  }
                },
                decoration:
                    const InputDecoration(hintText: "Enter Tip Percentage"),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      double billValue =
                          double.tryParse(billController.text) ?? 0.0;
                      double tipValue =
                          double.tryParse(tipController.text) ?? 0.0;
                      totalTip = billValue * (tipValue / 100);
                      totalBill = billValue + totalTip;
                    });
                  },
                  child: const Text("Calculate Tip"))
            ]),
          ),
        ));
  }
}

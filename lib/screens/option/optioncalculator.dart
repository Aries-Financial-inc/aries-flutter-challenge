import 'package:intl/intl.dart';

import '../../linker.dart';

class OptionCalculator extends StatefulWidget {
  const OptionCalculator({super.key});

  @override
  _OptionCalculatorState createState() => _OptionCalculatorState();
}

class _OptionCalculatorState extends State<OptionCalculator> {
  TextEditingController currentPriceController = TextEditingController();

  String result = '';

  List<OptionContract> options = [];

  double calculatePayoff(OptionContract option, double currentPrice) {
    double payoff;
    if (option.type == 'call') {
      payoff = (currentPrice > option.strikePrice
              ? currentPrice - option.strikePrice
              : 0) -
          option.premium;
    } else {
      payoff = (option.strikePrice > currentPrice
              ? option.strikePrice - currentPrice
              : 0) -
          option.premium;
    }
    return option.longShort == 'long' ? payoff : -payoff;
  }

  void calculateStrategyPayoff() {
    double currentPrice = double.tryParse(currentPriceController.text) ?? 0.0;

    double totalPayoff = 0.0;
    for (var option in options) {
      totalPayoff +=
          calculatePayoff(option, currentPrice) * (option.quantity ?? 1);
    }

    setState(() {
      result = 'The total payoff is \$${totalPayoff.toStringAsFixed(2)}';
    });
  }

  void openAddOptionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.8,
          // initialChildSize: 1,
          builder: (_, controller) {
            return AddOptionSheet(
              onAddOption: (option) {
                setState(() {
                  options.add(option);
                });
              },
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Option Strategy Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Current Price:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: currentPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Current Price'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: openAddOptionSheet,
              child: const Text('Add Option'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateStrategyPayoff,
              child: const Text('Calculate Strategy Payoff'),
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  var option = options[index];
                  return ListTile(
                    title: Text(
                        '${option.longShort == 'long' ? "Long" : "Short"} ${option.type.toUpperCase()} @ ${option.strikePrice} (Premium: ${option.premium})'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddOptionSheet extends StatefulWidget {
  final Function(OptionContract) onAddOption;

  const AddOptionSheet({super.key, required this.onAddOption});

  @override
  _AddOptionSheetState createState() => _AddOptionSheetState();
}

class _AddOptionSheetState extends State<AddOptionSheet> {
  TextEditingController strikePriceController = TextEditingController();
  TextEditingController askController = TextEditingController();
  TextEditingController bidController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String optionType = 'call'; // Default option type
  String longShort = 'long'; // Default position
  DateTime selectedDate = DateTime.now();

  void addOption() {
    double strikePrice = double.tryParse(strikePriceController.text) ?? 0.0;
    double ask = double.tryParse(askController.text) ?? 0.0;
    double bid = double.tryParse(bidController.text) ?? 0.0;
    double premium = (bid + ask) / 2;
    int? quantity = int.tryParse(quantityController.text);

    OptionContract option = OptionContract(
      type: optionType.capitalizeFirstLetter(),
      ask: ask,
      bid: bid,
      strikePrice: strikePrice,
      longShort: longShort.capitalizeFirstLetter(),
      premium: premium,
      quantity: quantity,
      expireDate: selectedDate,
    );

    widget.onAddOption(option);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomWidget.text6("Enter Option Parameters", fontSize: 18),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _reuseNumText(
              title: 'Strike Price',
              controller: strikePriceController,
            ),
            20.height,
            _reuseNumText(
              title: 'Ask Price',
              controller: askController,
            ),
            20.height,
            _reuseNumText(
              title: 'Bid Price',
              controller: bidController,
            ),
            20.height,
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: optionType,
                    onChanged: (String? newValue) {
                      setState(() {
                        optionType = newValue!;
                      });
                    },
                    items: <String>['call', 'put']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: CustomWidget.text6(value.capitalizeFirstLetter(),
                            fontSize: 14),
                      );
                    }).toList(),
                  ),
                ),
                50.width,
                Expanded(
                  child: DropdownButton<String>(
                    value: longShort,
                    onChanged: (String? newValue) {
                      setState(() {
                        longShort = newValue!;
                      });
                    },
                    items: <String>['long', 'short']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: CustomWidget.text6(
                              value.capitalizeFirstLetter(),
                              fontSize: 14)
                          // Text(value),
                          );
                    }).toList(),
                  ),
                ),
              ],
            ),
            ListTile(
              title: CustomWidget.text6(
                  "Expires: ${DateFormat('MMMM d, y h:mma').format(selectedDate)}"
                  // .split(' ')[0]
                  ),
              trailing: const Icon(Icons.keyboard_arrow_down),
              onTap: _selectDate,
            ),
            AppButton(
              onTap: addOption,
              child: const Text('Add Option'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reuseNumText(
      {required TextEditingController controller, required String title}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: CustomWidget.text6(title, fontSize: 14)),
        10.width,
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(),
          ),
        ),
      ],
    );
  }

  _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}

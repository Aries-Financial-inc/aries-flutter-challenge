import '../../../linker.dart';

class OptionsTable extends StatelessWidget {
  const OptionsTable({
    super.key,
    required this.provider,
  });

  final OptionsProvider provider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(80),
              1: FixedColumnWidth(100),
              2: FixedColumnWidth(100),
              3: FixedColumnWidth(100),
              4: FixedColumnWidth(100),
              5: FixedColumnWidth(100),
              6: FixedColumnWidth(150),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[800]),
                children: const [
                  TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Type',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )))),
                  TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Long/Short',
                              style: TextStyle(fontWeight: FontWeight.bold)))),
                  TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Strike Price',
                              style: TextStyle(fontWeight: FontWeight.bold)))),
                  TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Bid',
                              style: TextStyle(fontWeight: FontWeight.bold)))),
                  TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Ask',
                              style: TextStyle(fontWeight: FontWeight.bold)))),
                  TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Premium',
                              style: TextStyle(fontWeight: FontWeight.bold)))),
                  TableCell(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Expiration Date',
                              style: TextStyle(fontWeight: FontWeight.bold)))),
                ],
              ),
              for (var option in provider.contracts.reversed)
                TableRow(
                  decoration: BoxDecoration(
                      color: option.type.toLowerCase() == 'call'
                          ? Colors.green.withOpacity(0.3)
                          : Colors.red.withOpacity(0.3)),
                  children: [
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(option.type))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                option.longShort.capitalizeFirstLetter()))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(option.strikePrice.toString()))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(option.bid.toString()))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(option.ask.toString()))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(option.premium.toString()))),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(option.expireDate
                                .toLocal()
                                .toString()
                                .split(' ')[0]))),
                  ],
                ),
            ],
          ),
        ));
  }
}

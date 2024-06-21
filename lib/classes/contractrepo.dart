import '../linker.dart';

class ContractRepo {
  List<OptionContract> fetchOptionsData() {
    return optionsData.map((e) => OptionContract.fromJson(e)).toList();
  }
}

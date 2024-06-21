import '../linker.dart';

class OptionsProvider with ChangeNotifier {
  final ContractRepo _repo = ContractRepo();
  List<OptionContract> _contracts = [];
  List<OptionContract> get contracts => _contracts;
  bool get isLoadContract => _isLoadContract;
  bool _isLoadContract = false;

  OptionsProvider();

  Future<void> fetchContracts() async {
    try {
      _isLoadContract = true;
      notifyListeners();
      _contracts = _repo.fetchOptionsData();
      log(_contracts.length);
    } catch (e) {
      'Error fetching contracts : $e'.printlog();
    } finally {
      _isLoadContract = false;
      notifyListeners();
    }
  }

  co() {
    notifyListeners();
  }

  void addContract(OptionContract contract) {
    _contracts.add(contract);
    notifyListeners();
  }
}

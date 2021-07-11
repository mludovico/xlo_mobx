import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mobx/mobx.dart';

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStore with _$ConnectivityStore;

abstract class _ConnectivityStore with Store {
  _ConnectivityStore() {
    _setupListener();
  }

  @observable
  bool hasConnection = true;

  @action
  void setHasConnection(bool value) => hasConnection = value;

  void _setupListener() {
    final checker = DataConnectionChecker();
    checker.checkInterval = Duration(seconds: 5);
    checker.onStatusChange.listen((event) {
      setHasConnection(event == DataConnectionStatus.connected);
    });
  }
}

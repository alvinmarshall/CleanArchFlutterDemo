import 'package:data_connection_checker/data_connection_checker.dart';

abstract class INetworkInfo{
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements INetworkInfo{
  final DataConnectionChecker _connectionChecker;

  NetworkInfoImpl(this._connectionChecker);

  @override
  Future<bool> get isConnected => _connectionChecker.hasConnection;
}
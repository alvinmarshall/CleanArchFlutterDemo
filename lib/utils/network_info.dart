abstract class INetworkInfo{
  Future<bool> get isConnected;
}

class NetworkImpl implements INetworkInfo{
  @override
  Future<bool> get isConnected => throw UnimplementedError();
}
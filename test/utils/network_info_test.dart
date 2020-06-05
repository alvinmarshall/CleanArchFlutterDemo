import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learncleanarch/utils/network_info.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker{}

void main(){
  MockDataConnectionChecker mockDataConnectionChecker;
  NetworkInfoImpl networkInfoImpl;
  setUp((){
    mockDataConnectionChecker  = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group("Network state", (){
    test("should check network connection", (){
      final networkState = Future.value(true);
      when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => networkState);
      networkInfoImpl.isConnected;
      verify(mockDataConnectionChecker.hasConnection).called(1);
    });
  });
}
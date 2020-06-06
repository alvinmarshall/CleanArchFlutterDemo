import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learncleanarch/data/service/api/dto/user_dto.dart';
import 'package:learncleanarch/data/service/api_service.dart';
import 'package:learncleanarch/data/source/user_remote_source.dart';
import 'package:learncleanarch/utils/exception/exceptions.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:learncleanarch/extension/user_dto_to_model.dart';
import 'package:built_collection/built_collection.dart';
import '../../fixtures/read_fixture.dart';
import '../../utils/fake_user_service.dart';

class MockClient extends Mock implements http.Client {}

class MockChopperClient extends Mock implements ChopperClient {}

class MockApiService extends Mock implements ApiService {}

void main() {
  MockApiService mockApiService;
  UserRemoteSourceImpl userRemoteSourceImpl;
  const HTTP_OK = 200;
  const HTTP_FAIL = 400;
  const USER_IDENTIFIER = 1;

  setUp(() {
    mockApiService = MockApiService();
    userRemoteSourceImpl = UserRemoteSourceImpl(mockApiService);
  });

  group("Remote http 200", () {
    test("should get user with identifier from remote success", () async {
      var client = http.Response(getFixture("user.json"), HTTP_OK);
      var actual = FakeUserService.getUserModel()[0].asDto;
      when(mockApiService.getUser(USER_IDENTIFIER))
          .thenAnswer((_) async => Response(client, actual));
      var result = await userRemoteSourceImpl.fetchUser(USER_IDENTIFIER);
      print(result);
      verify(mockApiService.getUser(USER_IDENTIFIER)).called(1);
      verifyNoMoreInteractions(mockApiService);
    });

    test("should get users from remote success", () async {
      var client = http.Response(getFixture("users.json"), HTTP_OK);
      var dto = FakeUserService.getUserModel()[0].asDto;
      var actual = BuiltList<UserDto>([dto]);

      when(mockApiService.getUsers())
          .thenAnswer((_) async => Response(client, actual));
      var result = await userRemoteSourceImpl.fetchUsers();
      print(result);
      verify(mockApiService.getUsers()).called(1);
      verifyNoMoreInteractions(mockApiService);
    });
  });

  group("server exception", () {
    test("should fail when user with identifier from remote", () async {
      var client = http.Response(getFixture("user.json"), HTTP_FAIL);
      var actual = FakeUserService.getUserModel()[0].asDto;
      when(mockApiService.getUser(USER_IDENTIFIER))
          .thenAnswer((_) async => Response(client, actual));

      try {
        await userRemoteSourceImpl.fetchUser(USER_IDENTIFIER);
      } catch (e) {
        expect(e, isInstanceOf<ServerException>());
      }
    });

    test("should fail when get users from remote", () async {
      var client = http.Response(getFixture("users.json"), HTTP_FAIL);
      var dto = FakeUserService.getUserModel()[0].asDto;
      var actual = BuiltList<UserDto>([dto]);

      when(mockApiService.getUsers())
          .thenAnswer((_) async => Response(client, actual));
      try {
        await userRemoteSourceImpl.fetchUsers();
      } catch (e) {
        expect(e, isInstanceOf<ServerException>());
      }
    });
  });
}

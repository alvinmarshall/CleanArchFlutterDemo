// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ApiService extends ApiService {
  _$ApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = ApiService;

  Future<Response<BuiltList<UserDto>>> getUsers() {
    final $url = 'users';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<UserDto>, UserDto>($request);
  }

  Future<Response<UserDto>> getUser(int identifier) {
    final $url = 'users/${identifier}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<UserDto, UserDto>($request);
  }
}

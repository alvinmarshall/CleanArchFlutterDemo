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

  Future<Response<BuiltList<BuiltUser>>> getUsers() {
    final $url = 'users';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<BuiltUser>, BuiltUser>($request);
  }

  Future<Response<BuiltUser>> getUser(int identifier) {
    final $url = 'users/${identifier}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltUser, BuiltUser>($request);
  }
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:learncleanarch/data/model/user_model.dart';

import '../../fixtures/read_fixture.dart';

void main() {
  const dynamic USER_JSON = "user.json";
  group("from json ", () {
    test("should return a valid user model", () async {
      var jsonMap = json.decode(getFixture(USER_JSON));
      var result = UserModel.fromJson(jsonMap);
      print(jsonMap);
      print(result);
      expect(jsonMap['username'], result.username);
    });

    test("should return a valid List of user model", () async {
      var jsonMap = json.decode(getFixture("users.json"));
      List<UserModel> userList =
          (jsonMap as List).map((e) => UserModel.fromJson(e)).toList();
      print(userList);
    });
  });
}

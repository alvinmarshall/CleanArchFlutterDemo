import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:learncleanarch/data/service/serializer/serializers.dart';

part 'built_user.g.dart';

abstract class BuiltUser implements Built<BuiltUser, BuiltUserBuilder> {
  @nullable
  int get id;

  String get name;
  String get username;
  String get email;
  String get phone;


  BuiltUser._();
  factory BuiltUser([void Function(BuiltUserBuilder) updates]) = _$BuiltUser;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(BuiltUser.serializer, this);
  }

  static BuiltUser fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(BuiltUser.serializer, json);
  }

  static Serializer<BuiltUser> get serializer => _$builtUserSerializer;
}
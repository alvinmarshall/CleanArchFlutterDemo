
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:learncleanarch/data/service/serializer/serializers.dart';

part 'user_dto.g.dart';

abstract class UserDto implements Built<UserDto, UserDtoBuilder> {
  @nullable
  int get id;
  String get name;
  String get username;
  String get email;
  String get phone;
  UserDto._();

  factory UserDto([void Function(UserDtoBuilder) updates]) = _$UserDto;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(UserDto.serializer, this);
  }

  static UserDto fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserDto.serializer, json);
  }

  static Serializer<UserDto> get serializer => _$userDtoSerializer;
}

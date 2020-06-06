import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:learncleanarch/data/service/api/dto/user_dto.dart';

part 'serializers.g.dart';

@SerializersFor(const [UserDto])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
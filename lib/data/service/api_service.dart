import 'package:chopper/chopper.dart';
import 'package:learncleanarch/data/service/converter/build_value_converter.dart';
import 'package:learncleanarch/data/service/dto/user_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:learncleanarch/utils/constants.dart';
part 'api_service.chopper.dart';

@ChopperApi(baseUrl: "users")
abstract class ApiService extends ChopperService {
  @Get()
  Future<Response<BuiltList<UserDto>>> getUsers();

  @Get(path: "/{id}")
  Future<Response<UserDto>> getUser(@Path("id") int identifier);

  static ApiService create() {
    final client = ChopperClient(
      baseUrl: BASE_URL,
      services: [_$ApiService()],
      converter: BuildValueConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$ApiService(client);
  }
}

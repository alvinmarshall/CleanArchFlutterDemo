import 'package:chopper/chopper.dart';
import 'package:learncleanarch/utils/constants.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: BASE_URL)
abstract class ApiService extends ChopperService {
  @Get(path: "users")
  Future<Response> getUsers();

  @Get(path: "user/{id}")
  Future<Response> getUser(@Path("id") int identifier);
}

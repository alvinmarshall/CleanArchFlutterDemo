import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';
import 'package:learncleanarch/data/service/api/serializer/serializers.dart';

class BuildValueConverter extends JsonConverter {
  T _deserialize<T>(Map<String, dynamic> element) {
    return serializers.deserializeWith<T>(
        serializers.serializerForType(T), element);
  }

  BuiltList<T> _deserializeListOf<T>(List<dynamic> elementList) {
    return BuiltList<T>(elementList.map((e) => _deserialize(e)));
  }

  @override
  Request convertRequest(Request request) {
    return super.convertRequest(request.replace(
        body: serializers.serializeWith(
            serializers.serializerForType(request.body.runtimeType),
            request.body)));
  }

  @override
  Response<BodyType> convertResponse<BodyType, T>(Response response) {
    final jsonResponse = super.convertResponse(response);
    final customBody = _convertToCustomBodyType<T>(jsonResponse.body);
    return jsonResponse.replace<BodyType>(body: customBody);
  }

  dynamic _convertToCustomBodyType<T>(dynamic element) {
    if (element is T) return element;
    if (element is List) return _deserializeListOf<T>(element);
    return _deserialize(element);
  }
}

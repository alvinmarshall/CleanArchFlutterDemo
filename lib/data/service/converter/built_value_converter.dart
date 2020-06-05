import 'package:chopper/chopper.dart';
import 'package:learncleanarch/data/service/serializer/serializers.dart';
import 'package:built_collection/built_collection.dart';

class BuiltValueConverter extends JsonConverter {
  SingleItemType _deserialize<SingleItemType>(Map<String, dynamic> element) {
    return serializers.deserializeWith<SingleItemType>(
        serializers.serializerForType(SingleItemType), element);
  }

  BuiltList<SingleItemType> _deserializeListOf<SingleItemType>(
      List elementList) {
    return BuiltList<SingleItemType>(elementList.map((e) => _deserialize(e)));
  }

  @override
  Request convertRequest(Request request) {
    return super.convertRequest(request.replace(
        body:
            serializers.serializeWith(request.body.runtimeType, request.body)));
  }

  @override
  Response<BodyType> convertResponse<BodyType, SingleItemType>(
      Response response) {
    final Response dynamicResponse = super.convertResponse(response);
    final BodyType customBody = _convertToCustomObject<SingleItemType>(dynamicResponse.body);
    return dynamicResponse.replace<BodyType>(body: customBody);
  }

  dynamic _convertToCustomObject<SingleItemType>(dynamic element) {
    if (element is SingleItemType) return element;
    if (element is List) return _deserializeListOf<SingleItemType>(element);
    return _deserialize<SingleItemType>(element);
  }
}

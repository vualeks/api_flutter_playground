import 'dart:async';
import 'package:chopper/chopper.dart';

part 'my_service.chopper.dart';

@ChopperApi()
abstract class MyService extends ChopperService {
  static MyService create([ChopperClient client]) => _$MyService(client);

  @Post(path: '/account/loginjson')
  Future<Response> login(@Body() String email, String password);
}

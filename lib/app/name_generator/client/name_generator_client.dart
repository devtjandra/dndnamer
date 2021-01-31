import 'package:dio/dio.dart';

class NameGeneratorClient {
  final _baseUrl = "https://donjon.bin.sh/name/rpc-name.fcgi?n=10&type=";

  Future<List<String>> getNames(String type) async {
    final dio = Dio();
    final response = await dio.get(_baseUrl + type.replaceAll(" ", "+"));
    return (response.data as String).split("\n");
  }
}

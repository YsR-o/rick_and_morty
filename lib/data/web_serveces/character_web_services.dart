import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data/model/info_model.dart';
import 'package:dio/dio.dart';

class CharacterServices {
  late Dio dio;
  CharacterServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseurl,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<Map<String, dynamic>>> getAllCharacters(String url) async {
    List<Map<String, dynamic>> allEntities = [];
    try {
      allCharacternextUrl = url;
      Response response = await dio.get(allCharacternextUrl!);
      var dataInfo = response.data["info"];
      Info info = Info.fromJson(dataInfo);
      allCharacternextUrl = info.next;
      allEntities
          .addAll(List<Map<String, dynamic>>.from(response.data["results"]));
      print(allCharacternextUrl);
      return allEntities;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

   Future<List<Map<String, dynamic>>> getSearchedCharacters(String url) async {
    List<Map<String, dynamic>> allEntities = [];
    try {
      serchingnextUrl = url;
      Response response = await dio.get(serchingnextUrl!);
      var dataInfo = response.data["info"];
      Info info = Info.fromJson(dataInfo);
      serchingnextUrl = info.next;
      allEntities
          .addAll(List<Map<String, dynamic>>.from(response.data["results"]));
      print(serchingnextUrl);
      return allEntities;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}

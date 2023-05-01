import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'api_key.dart';

class MovieApi {
  String api_key = API_KEY;
  String listCout = '30';

  Future<List<Map<dynamic, dynamic>>> movieSearch(
      {required String keyword}) async {
    String url =
        'https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?listCount=$listCout&collection=kmdb_new2&detail=Y&query=$keyword&ServiceKey=$api_key&ratedYn=Y';

    print(url);
    var response = await http.get(Uri.parse(url));

    List<Map<dynamic, dynamic>> moiveList = [];
    if (response.statusCode == 200) {
      var movieJson = convert.jsonDecode(response.body) as Map<String, dynamic>;

      var movies = movieJson['Data'][0]['Result'] as List<dynamic>;

      for (var k in movies) {
        if (k['rating'] != '18세관람가(청소년관람불가)') {
          moiveList.add(k);
        }
      }
    }

    return moiveList;
  }
}

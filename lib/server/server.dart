import 'package:http/http.dart' as http;
import 'package:restful_api/model/Model.dart';
const URL = "https://jsonplaceholder.typicode.com/posts";
class Server{
  Future<List<MovieModel>?> getPost() async{
    var client = http.Client();
    var uri = Uri.parse(URL);
    var res = await client.get(uri);

    if(res.statusCode ==200){
      var json = res.body;
      return movieModelFromMap(json);
    }

  }
}

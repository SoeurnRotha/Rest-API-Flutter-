import 'package:http/http.dart' as http;
import 'package:restful_api/model/StoreModel.dart';
const url = "https://fakestoreapi.com/products";
const limit = "https://fakestoreapi.com/products?limit=5";
class StoreServer{
  Future<List<StoreModel>?> getStore() async{
    var client = http.Client();
    var uri = Uri.parse(url);
    var res = await client.get(uri);
    if(res.statusCode == 200){
      var json = res.body;
      return storeModelFromMap(json);
    }
    return null;
  }

  Future<List<StoreModel>?> getLimitProduct() async{
    var clinet = http.Client();
    var uri = Uri.parse(limit);
    var res = await clinet.get(uri);
    if(res.statusCode==200){
      var json = res.body;
      return storeModelFromMap(json);
    }
    return null;
  }


}
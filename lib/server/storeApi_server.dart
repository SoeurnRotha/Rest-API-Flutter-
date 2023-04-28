import 'package:http/http.dart' as http;
import 'package:restful_api/model/StoreModel.dart';
const url = "https://fakestoreapi.com/products";
const limit = "https://fakestoreapi.com/products?limit=5";
const category = "https://fakestoreapi.com/products/categories";

class StoreServer{
  Future<List<StoreModel>> getStore() async{
    var client = http.Client();
    var uri = Uri.parse(url);
    var res = await client.get(uri);
    if(res.statusCode == 200){
      var json = res.body;
      return storeModelFromMap(json);
    }
    else{
      throw Exception('Error to load posts');
    }
  }

  Future<List<StoreModel>> getLimitProduct() async{
    var clint = http.Client();
    var uri = Uri.parse(limit);
    var res = await clint.get(uri);
    if(res.statusCode==200){
      var json = res.body;
      return storeModelFromMap(json);
    }else{
      throw Exception('Error to load posts');
    }
  }
  
  Future<List<String>> getAllCategory() async{
    var clint = http.Client();
    var uri = Uri.parse(category);
    var res = await clint.get(uri);
    if(res.statusCode == 200){
      var json  = res.body;
      return categortModelFromMap(json);
    }else{
      throw Exception('Error Load post');
    }
  }


}
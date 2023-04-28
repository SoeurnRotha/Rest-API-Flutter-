import 'package:flutter/material.dart';
import 'package:restful_api/model/StoreModel.dart';
import 'package:restful_api/server/storeApi_server.dart';
class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<StoreModel>? storeModel;
  StoreServer storeServer = StoreServer();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FutureBuilder<List<String>>(
        future: storeServer.getAllCategory(),
        builder: (context , snapshort){
          if(snapshort.hasData){
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: snapshort.data?.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snapshort.data![index],style: TextStyle(fontSize: 15,),),
                    ),
                  ),
                );
              },
            );
          }else if(snapshort.hasError){
            return const Text("Error");
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }

        },
      ),
    );
  }
}

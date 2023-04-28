import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restful_api/model/StoreModel.dart';
import 'package:restful_api/screen/DetailPage.dart';
import 'package:restful_api/server/storeApi_server.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StoreServer storeServer = StoreServer();

  @override
  Widget build(BuildContext context) {
    return _buildListView;
  }
  get _buildListView{
    return FutureBuilder<List<StoreModel>>(
      future: storeServer.getStore(),
      builder: (context , snapshot){
        if(snapshot.hasData){
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 350
            ),
            itemCount: snapshot.data?.length,
            itemBuilder: (context , index){
              return Container(
                height: 250,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(storeModel: snapshot.data![index],))),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.network(snapshot.data![index].image,height: 170,fit: BoxFit.cover,width: double.infinity),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data![index].title,maxLines: 2,overflow: TextOverflow.ellipsis,),
                            Text("${snapshot.data![index].price}",maxLines: 2,overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(CupertinoIcons.heart),
                                  onPressed: (){

                                  },
                                ),
                                IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.cart))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }else if(snapshot.hasError){
          return const Text("Error");
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}

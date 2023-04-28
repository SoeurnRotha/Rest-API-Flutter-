import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restful_api/model/StoreModel.dart';
import 'package:restful_api/screen/ImageSlider.dart';
import 'package:restful_api/server/storeApi_server.dart';
void main(){
  runApp(const RestFulAPI());
}

class RestFulAPI extends StatefulWidget {
  const RestFulAPI({Key? key}) : super(key: key);

  @override
  State<RestFulAPI> createState() => _RestFulAPIState();
}

class _RestFulAPIState extends State<RestFulAPI> {
  List<StoreModel>? storeModel;
  bool isLoadding = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetch data from api
    getDataFromStore();
  }
  getDataFromStore() async{
    storeModel = await StoreServer().getStore();
    if(storeModel != null){
      setState(() {
        isLoadding = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: buildScaffold(context),
    );
  }
  Widget buildScaffold(BuildContext context){
    return Scaffold(
      appBar: _buildAppbar,
      body: _buildBody(context),
    );
  }
  get _buildAppbar{
    return AppBar(
      title: const Text("Test"),
    );
  }
  Widget _buildBody(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          const ImageSlider(),
          _buildListView
        ],
      ),
    );
  }

  get _buildListView{
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 300
      ),
      itemCount: storeModel?.length,
      itemBuilder: (context , index){
        return Container(
          height: 250,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                  child: Image.network(storeModel![index].image,height: 170,fit: BoxFit.cover,width: double.infinity)
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(storeModel![index].title,maxLines: 2,overflow: TextOverflow.ellipsis,),
                    Text("${storeModel![index].price}",maxLines: 2,overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold),),
                    Row(
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
        );
      },

    );
  }

}

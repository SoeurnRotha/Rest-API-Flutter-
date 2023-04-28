import 'package:flutter/material.dart';
import 'package:restful_api/model/StoreModel.dart';
import 'package:restful_api/screen/DetailPage.dart';
import 'package:restful_api/screen/ImageSlider.dart';
import 'package:restful_api/screen/category.dart';
import 'package:restful_api/screen/home.dart';
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
  StoreModel? storeModel;
  StoreServer storeServer = StoreServer();
  bool isLoading = false;
  List<StoreModel>? storeList;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context) => buildScaffold(context),
        '/detail': (context)=> DetailPage(storeModel: storeModel!)
      },
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
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        child: Column(
            children: const [
              ImageSlider(),
              Category(),
              HomePage()
            ],
          ),
      ),
    );
  }

  Future<void> _refreshData() async{
    setState(() {
      isLoading = true;
    });

    try{
      List<StoreModel> newData = await storeServer.getStore();
      setState(() {
        storeList = newData;
        isLoading = false;
      });
    }catch(e){
      setState(() {
        isLoading = false;
      });
    }
  }

}

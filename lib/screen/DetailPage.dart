import 'package:flutter/material.dart';
import 'package:restful_api/model/StoreModel.dart';
class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.storeModel}) : super(key: key);
  final StoreModel storeModel;


  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: _buildBody,
      bottomSheet: _buildBottomSheet,
    );
  }
  get _buildBottomSheet{
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: (){

        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 40)
        ),
        child: const Text("Add To cart"),
      ),
    );
  }
  get _buildBody{
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.storeModel.image),
                fit: BoxFit.contain
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                    child: Text(widget.storeModel.title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ),
                SizedBox(
                  child: Text("\$${widget.storeModel.price}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.storeModel.description,style: const TextStyle(fontSize: 10),),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:restful_api/model/StoreModel.dart';
import 'package:restful_api/server/storeApi_server.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<StoreModel>? storeModel;
  bool isLoading = false;
  PageController controller = PageController();
  int activeIndex = 0;
  CarouselController carouselController = CarouselController();


  @override
  void initState() {
    super.initState();
    getDataLimitProduct();
  }
  getDataLimitProduct() async{
    storeModel = await StoreServer().getLimitProduct();
    if(storeModel != null){
      setState(() {
        isLoading =true;

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: storeModel?.length,
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(storeModel![itemIndex].image),
                          fit: BoxFit.contain
                      )
                  ),
                ),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16/9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index , next)=>{
                setState(()=>{
                  activeIndex = index
                })
              }
          ),
          carouselController: carouselController,
        ),
        _buildSmootPage
      ],
    );
  }
  get _buildSmootPage{
    return Container(
      color: Colors.white,
      height: 100,
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: storeModel!.length,
        effect: const WormEffect(),
        onDotClicked: (index){

        },
      ),
    );
  }
}

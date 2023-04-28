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
  int activeIndex = 0;
  CarouselController carouselController = CarouselController();
  StoreServer storeServer = StoreServer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<StoreModel>>(
          future: storeServer.getLimitProduct(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return CarouselSlider.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data![itemIndex].image),
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
              );
            }else if(snapshot.hasError){
              return const Text("Error");
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        FutureBuilder<List<StoreModel>>(
          future: storeServer.getLimitProduct(),
            builder: (context , snapshot){
              if(snapshot.hasData){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: snapshot.data!.length,
                    effect: const SlideEffect(
                        spacing:  8.0,
                        radius:  4.0,
                        dotWidth:  10.0,
                        dotHeight:  10.0,
                        paintStyle:  PaintingStyle.fill,
                        strokeWidth:  1.5,
                        dotColor:  Colors.grey,
                        activeDotColor:  Colors.indigo
                    ),
                    onDotClicked: (index){

                    },
                  ),
                );
              }else if(snapshot.hasError){
                return const Text("Error");
              }else{
                return const Center(child: CircularProgressIndicator());
              }
          }
        )
      ],
    );
  }

}

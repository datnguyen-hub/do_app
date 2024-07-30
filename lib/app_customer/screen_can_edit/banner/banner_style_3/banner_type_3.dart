import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../screen_default/data_app_controller.dart';

class BannerType3 extends StatefulWidget {
  @override
  _BannerType3State createState() => _BannerType3State();

  final double? height;

  BannerType3({this.height});
}

class _BannerType3State extends State<BannerType3> {
  int _current = 0;
  double? height;

  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    height = widget.height;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      dataAppCustomerController.homeData.value.banner?.list == null
          ? Container()
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider(
                  items: dataAppCustomerController.homeData.value.banner!.list!
                      .map((item) => Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                  imageUrl: item.imageUrl!,
                                  placeholder: (context, url) =>
                                      SahaLoadingContainer(),
                                  errorWidget: (context, url, error) =>
                                      SahaEmptyImage(),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 16 / 9.0,
                    viewportFraction: 0.85,
                    enlargeCenterPage: true,
                  ),
                ),
                dataAppCustomerController.homeData.value.banner?.list == null
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: dataAppCustomerController
                            .homeData.value.banner!.list!
                            .map((url) {
                          int index = dataAppCustomerController
                              .homeData.value.banner!.list!
                              .indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
    ]);
  }
}

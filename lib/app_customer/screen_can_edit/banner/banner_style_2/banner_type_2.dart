import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import '../../../components/empty/saha_empty_image.dart';
import '../../../screen_default/data_app_controller.dart';

class BannerType2 extends StatefulWidget {
  @override
  _BannerType2State createState() => _BannerType2State();

  final double? height;

  BannerType2({this.height});
}

class _BannerType2State extends State<BannerType2> {
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
          : Container(
              width: Get.width,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    items: dataAppCustomerController
                        .homeData.value.banner!.list!
                        .map(
                          (item) => Padding(
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
                        )
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.vertical,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ],
              ),
            ),
    ]);
  }
}

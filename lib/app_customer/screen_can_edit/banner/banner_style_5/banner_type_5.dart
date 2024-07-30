import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import '../../../components/empty/saha_empty_image.dart';

import '../../../screen_default/data_app_controller.dart';

class BannerType5 extends StatefulWidget {
  @override
  _BannerType1State createState() => _BannerType1State();

  final double? height;

  BannerType5({this.height});
}

class _BannerType1State extends State<BannerType5> {
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
              child: CarouselSlider(
                items: dataAppCustomerController.homeData.value.banner!.list!
                    .map((item) => ClipRRect(
                            child: Stack(
                          children: <Widget>[
                            CachedNetworkImage(
                              width: Get.width,
                              fit: BoxFit.cover,
                              imageUrl: item.imageUrl!,
                              placeholder: (context, url) =>
                                  SahaLoadingContainer(),
                              errorWidget: (context, url, error) =>
                                  SahaEmptyImage(),
                            ),
                          ],
                        )))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                    aspectRatio: 16 / 9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),


    ]);
  }
}

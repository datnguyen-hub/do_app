import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/empty/saha_empty_image.dart';

import '../../../screen_default/data_app_controller.dart';

class BannerType6 extends StatefulWidget {
  @override
  _BannerType1State createState() => _BannerType1State();

  final double? height;

  BannerType6({this.height});
}

class _BannerType1State extends State<BannerType6> {
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
              height: height,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: Get.width,
                    child: CarouselSlider(
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
                                child: InkWell(
                                  onTap: () {
                                    launchUrl(
                                        Uri.parse(
                                          item.linkTo ?? "",
                                        ),
                                        mode: LaunchMode.externalApplication);
                                  },
                                  child: CachedNetworkImage(
                                    width: Get.width,
                                    fit: BoxFit.fill,
                                    imageUrl: item.imageUrl!,
                                    placeholder: (context, url) =>
                                        SahaLoadingContainer(),
                                    errorWidget: (context, url, error) =>
                                        SahaEmptyImage(),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: false,
                          viewportFraction: 1,
                          aspectRatio: 16 / 10,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  ),
                  dataAppCustomerController.homeData.value.banner?.list == null
                      ? Container()
                      : Positioned(
                          bottom: 0,
                          child: Row(
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
                        ),
                ],
              ),
            ),
    ]);
  }
}

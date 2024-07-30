import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:sahashop_customer/app_customer/config_controller.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/banner/banner_widget.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/search_bar_type/search_bar_type1.dart';
import '../home_body.dart';
import 'home_style_5_controller.dart';

class HomeScreenStyle5 extends StatefulWidget {
  const HomeScreenStyle5({Key? key}) : super(key: key);

  @override
  _HomeScreenStyle5State createState() => _HomeScreenStyle5State();
}

class _HomeScreenStyle5State extends State<HomeScreenStyle5> {
  final ScrollController _scrollController = ScrollController();
  final HomeStyle5Controller homeStyle5Controller = HomeStyle5Controller();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController.addListener(() {
      if (_scrollController.offset > 1 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        homeStyle5Controller.isTouch.value = true;
      } else if (_scrollController.offset < 1 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        homeStyle5Controller.isTouch.value = false;
      }
    });
    configController.addButton(context);
  }

  CustomerConfigController configController = Get.find();
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Theme.of(context).primaryColor,
          ),
          Column(
            children: [
              Obx(
                () => SizedBox(
                  height: homeStyle5Controller.isTouch.value ? 0 : 40,
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  color: Colors.indigo,
                  onRefresh: () async {
                    await homeStyle5Controller.refresh();
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        BannerWidget(),
                        if (dataAppCustomerController
                                    .homeData.value.bannerAdsApp?.position0 !=
                                null &&
                            dataAppCustomerController
                                .homeData.value.bannerAdsApp!.position0!.isNotEmpty)
                          bannerAdsItem(dataAppCustomerController
                              .homeData.value.bannerAdsApp!.position0!),
                        Obx(() => homeStyle5Controller.isRefresh.value
                            ? HomeBodyWidget()
                            : HomeBodyWidget()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              top: homeStyle5Controller.isTouch.value ? 40 : 60,
              height: 40,
              right: homeStyle5Controller.isTouch.value ? 20 : 10,
              left: 10,
              //width: Get.width,
              child: SearchBarType1(
                onSearch: () {
                  Get.to(CategoryProductScreen(
                    autoSearch: true,
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({Key? key, this.category}) : super(key: key);

  final Category? category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(CategoryProductScreen(
            categoryId: category!.id,
          ));
        },
        child: Stack(
          children: [
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 0.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: category!.imageUrl ?? "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SahaLoadingContainer(),
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  AutoSizeText(
                    category!.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 2,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

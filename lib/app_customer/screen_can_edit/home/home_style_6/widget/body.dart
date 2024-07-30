import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/product_item/post_item_widget.dart';
import 'package:sahashop_customer/app_customer/model/button_home.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/home_buttons/list_home_button.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/action_tap.dart';

import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/loading/loading_container.dart';
import '../../../../components/widget/blinking_text.dart';
import '../../../../model/banner_ads.dart';
import '../../../product_item_widget/product_item_sale/product_item_sale.dart';

class HomeBodyWidget6 extends StatelessWidget {
  DataAppCustomerController dataAppCustomerController = Get.find();

  List<Widget> listLayout() {
    List<Widget> list = [];
    if (dataAppCustomerController.homeData.value.listLayout != null) {
      for (var layout in dataAppCustomerController.homeData.value.listLayout!) {
        if (layout.hide == true || layout.list!.length == 0) {
          list.add(Container());
          continue;
        }

        list.add(layout.model == "HomeButton"
            ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, left: 8),
                      child: Text(
                        "Tiện ích của tôi",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListHomeButtonWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 8,
                      color: Colors.grey[100],
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (layout.typeLayout == 'PRODUCTS_TOP_SALES' &&
                      dataAppCustomerController
                              .homeData.value.bannerAdsApp?.position1 !=
                          null &&
                      dataAppCustomerController
                          .homeData.value.bannerAdsApp!.position1!.isNotEmpty)
                    bannerAdsItem(dataAppCustomerController
                        .homeData.value.bannerAdsApp!.position1!),
                  if (layout.typeLayout == 'PRODUCTS_NEW' &&
                      dataAppCustomerController
                              .homeData.value.bannerAdsApp?.position2 !=
                          null &&
                      dataAppCustomerController
                          .homeData.value.bannerAdsApp!.position2!.isNotEmpty)
                    bannerAdsItem(dataAppCustomerController
                        .homeData.value.bannerAdsApp!.position2!),
                  if (layout.typeLayout == 'PRODUCTS_DISCOUNT' &&
                      dataAppCustomerController
                              .homeData.value.bannerAdsApp?.position3 !=
                          null &&
                      dataAppCustomerController
                          .homeData.value.bannerAdsApp!.position3!.isNotEmpty)
                    bannerAdsItem(dataAppCustomerController
                        .homeData.value.bannerAdsApp!.position3!),
                  if (layout.typeLayout == 'POSTS_NEW' &&
                      dataAppCustomerController
                              .homeData.value.bannerAdsApp?.position4 !=
                          null &&
                      dataAppCustomerController
                          .homeData.value.bannerAdsApp!.position4!.isNotEmpty)
                    bannerAdsItem(dataAppCustomerController
                        .homeData.value.bannerAdsApp!.position4!),
                  if (layout.model == "Product" &&
                      layout.typeLayout == 'PRODUCTS_DISCOUNT')
                    Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red, width: 1.5)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                BlinkText("Khuyến mại hấp dẫn".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold),
                                    beginColor: Colors.yellow,
                                    endColor: Colors.red,
                                    times: 1000,
                                    duration: Duration(milliseconds: 500)),
                                Image.asset(
                                  "packages/sahashop_customer/assets/images/flashsale_hot.webp",
                                  height: 30,
                                  width: 30,
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    ActionTap.onTap(
                                      typeAction: layout.typeLayout ==
                                              'PRODUCT_BY_CATEGORY'
                                          ? 'PRODUCT_BY_CATEGORY'
                                          : layout.typeActionMore ??
                                              "CATEGORY_PRODUCT",
                                      value: layout.value,
                                    );
                                  },
                                  child: Text(
                                    "Tất cả",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, top: 8, right: 0, bottom: 8),
                            child: Container(
                              height: dataAppCustomerController
                                          .infoCustomer.value.isCollaborator ==
                                      true
                                  ? 200
                                  : 170,
                              width: layout.list!.cast<Product>().length * 180,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      layout.list!.cast<Product>().length,
                                  itemBuilder: (context, index) {
                                    return ProductItemWidgetSale(
                                      width: Get.width / 3.5,
                                      product:
                                          layout.list!.cast<Product>()[index],
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  if (layout.typeLayout != 'PRODUCTS_DISCOUNT')
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 15, top: 10, bottom: 10),
                      child: SectionTitle(
                        title: layout.title ?? "",
                        titleEnd: "Tất cả",
                        colorTextMore: Colors.blueAccent,
                        pressTitleEnd: () {
                          ActionTap.onTap(
                            typeAction: layout.typeLayout ==
                                    'PRODUCT_BY_CATEGORY'
                                ? 'PRODUCT_BY_CATEGORY'
                                : layout.typeActionMore ?? "CATEGORY_PRODUCT",
                            value: layout.value,
                          );
                        },
                      ),
                    ),
                  if (layout.model == "Product" &&
                      layout.typeLayout != 'PRODUCTS_DISCOUNT')
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, top: 8, right: 0, bottom: 8),
                          child: Container(
                            height: dataAppCustomerController.infoCustomer.value
                                            .isCollaborator ==
                                        true ||
                                    dataAppCustomerController
                                            .infoCustomer.value.isAgency ==
                                        true
                                ? 300
                                : 271,
                            width: layout.list!.cast<Product>().length * 180,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: layout.list!.cast<Product>().length,
                                itemBuilder: (context, index) {
                                  return ProductItemWidget(
                                    width: 180,
                                    product:
                                        layout.list!.cast<Product>()[index],
                                  );
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 8,
                          color: Colors.grey[100],
                        ),
                      ],
                    ),
                  if (layout.model == "Category")
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 8.0),
                          child: Container(
                            width: Get.width,
                            height: 90,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: layout.list!.cast<Category>().length,
                                itemBuilder: (context, index) {
                                  return CategoryButton(
                                    category:
                                        layout.list!.cast<Category>()[index],
                                  );
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 8,
                          color: Colors.grey[100],
                        ),
                      ],
                    ),
                  if (layout.model == "Post")
                    Column(
                      children: [
                        SizedBox(
                          width: Get.width,
                          height: 120,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: layout.list!.cast<Post>().length,
                              itemBuilder: (context, index) {
                                return PostItemWidget(
                                  width: 300,
                                  post: layout.list!.cast<Post>()[index],
                                );
                              }),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 8,
                          color: Colors.grey[100],
                        ),
                      ],
                    ),
                ],
              ));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: listLayout(),
    );
  }
}

Widget bannerAdsItem(List<BannerAds> listBannerAdsItem) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: Get.width,
          child: CarouselSlider(
            items: listBannerAdsItem
                .map(
                  (item) => InkWell(
                    onTap: () {
                      ActionTap.onTap(
                          typeAction: item.typeAction,
                          value: item.value,
                          thenAction: () {});
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
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
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
                autoPlay: listBannerAdsItem.length <= 1 ? false : true,
                enlargeCenterPage: false,
                viewportFraction: 1,
                aspectRatio: 16 / 9,
                onPageChanged: (index, reason) {}),
          ),
        ),
      ],
    ),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.titleEnd,
    this.pressTitleEnd,
    this.colorTextTitle,
    this.colorTextMore,
    this.onClear,
  }) : super(key: key);

  final String title;
  final String? titleEnd;
  final Color? colorTextTitle;
  final Color? colorTextMore;
  final Function? onClear;

  final GestureTapCallback? pressTitleEnd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: colorTextTitle ?? Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onClear != null)
                InkWell(
                  onTap: onClear != null
                      ? () {
                          onClear!();
                        }
                      : null,
                  child: Icon(
                    Icons.clear,
                    size: 18,
                  ),
                )
            ],
          ),
        ),
        pressTitleEnd == null
            ? Container()
            : GestureDetector(
                onTap: pressTitleEnd,
                child: Text(
                  "${titleEnd == null ? "" : titleEnd}",
                  style: TextStyle(
                      color: colorTextMore ?? Colors.grey[500],
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
              ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({Key? key, this.category}) : super(key: key);

  final Category? category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ActionTap.onTap(
          typeAction: mapTypeAction[TYPE_ACTION.CATEGORY_PRODUCT],
          value: category!.id.toString(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: HomeButtonWidget(HomeButton(
            title: category!.name!,
            value: category!.id.toString(),
            typeAction: mapTypeAction[TYPE_ACTION.CATEGORY_PRODUCT],
            imageUrl: category!.imageUrl)),
      ),
    );
  }
}

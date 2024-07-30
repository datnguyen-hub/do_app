import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/utils/action_tap.dart';

import '../../../app_customer/screen_default/data_app_controller.dart';
import '../../components//loading/loading_container.dart';
import '../../config_controller.dart';
import '../../model/button_home.dart';
import '../repository_widget_config.dart';

Widget buildImageButton({String? imageUrl, String? typeAction}) {
  Widget? svgImage;

  if (typeAction == mapTypeAction[TYPE_ACTION.CALL]) {
    svgImage = decorationButton(
      color: Colors.cyan,
      child: Center(
        child: SvgPicture.asset(
            "packages/sahashop_customer/assets/app_customer/home_button/telephone.svg",
            width: 32,
            height: 32,
            color: Colors.cyan),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.MESSAGE_TO_SHOP]) {
    svgImage = decorationButton(
      color: Colors.teal,
      child: Center(
        child: SvgPicture.asset(
            "packages/sahashop_customer/assets/app_customer/home_button/chat.svg",
            width: 35,
            height: 35,
            color: Colors.teal),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.CALL]) {
    svgImage = decorationButton(
      color: Colors.teal,
      child: Center(
        child: SvgPicture.asset(
            "packages/sahashop_customer/assets/app_customer/home_button/chat.svg",
            width: 35,
            height: 35,
            color: Colors.teal),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.VOUCHER]) {
    svgImage = decorationButton(
      color: Colors.blue,
      child: Center(
        child: SvgPicture.asset(
            "packages/sahashop_customer/assets/app_customer/home_button/voucher2.svg",
            width: 35,
            height: 35,
            color: Colors.blue),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.QR]) {
    svgImage = decorationButton(
      color: Colors.orange,
      child: Center(
        child: SvgPicture.asset(
            "packages/sahashop_customer/assets/app_customer/home_button/qr-code.svg",
            width: 35,
            height: 35,
            color: Colors.orange),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.SPIN_WHEEL]) {
    svgImage = decorationButton(
      color: Colors.red,
      child: Center(
        child: SvgPicture.asset(
            "packages/sahashop_customer/assets/app_customer/home_button/games.svg",
            width: 35,
            height: 35,
            color: Colors.red),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.GUESS_NUMBER]) {
    svgImage = decorationButton(
      color: Colors.red,
      child: Center(
        child: SvgPicture.asset(
          "packages/sahashop_customer/assets/app_customer/home_button/games.svg",
          width: 35,
          height: 35,
          color: Colors.red,
        ),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_TOP_SALES]) {
    svgImage = decorationButton(
      color: Colors.pink,
      child: Center(
        child: SvgPicture.asset(
          "packages/sahashop_customer/assets/app_customer/home_button/rank.svg",
          width: 35,
          height: 35,
          color: Colors.pink,
        ),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_NEW]) {
    svgImage = decorationButton(
      color: Colors.green,
      child: Center(
        child: SvgPicture.asset(
          "packages/sahashop_customer/assets/app_customer/home_button/new.svg",
          width: 35,
          height: 35,
          color: Colors.green,
        ),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.PRODUCTS_DISCOUNT]) {
    svgImage = decorationButton(
      color: Colors.purple,
      child: Center(
        child: SvgPicture.asset(
            "packages/sahashop_customer/assets/app_customer/home_button/discount.svg",
            width: 35,
            height: 35,
            color: Colors.purple),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.SCORE]) {
    svgImage = decorationButton(
      color: Colors.redAccent,
      child: Center(
        child: SvgPicture.asset(
            "packages/sahashop_customer/assets/app_customer/home_button/score.svg",
            width: 35,
            height: 35,
            color: Colors.redAccent),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.COMBO]) {
    svgImage = decorationButton(
      color: Colors.pinkAccent,
      child: Center(
        child: SvgPicture.asset(
            "packages/sahashop_customer/assets/app_customer/home_button/packages.svg",
            width: 35,
            height: 35,
            color: Colors.pinkAccent),
      ),
    );
  } else if (typeAction == mapTypeAction[TYPE_ACTION.BONUS_PRODUCT]) {
    svgImage = decorationButton(
      color: Colors.orange,
      child: Center(
        child: SvgPicture.asset(
            "packages/sahashop_customer/assets/app_customer/home_button/gifts.svg",
            width: 35,
            height: 35,
            color: Colors.orange),
      ),
    );
  } else {
    if (imageUrl != null) {
      svgImage = CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => SahaLoadingContainer(),
        errorWidget: (context, url, error) => SahaEmptyImage(),
      );
    } else {
      svgImage = Center(
        child: SvgPicture.asset(
          "packages/sahashop_customer/assets/app_customer/home_button/forward.svg",
          width: 35,
          height: 35,
        ),
      );
    }
  }

  return svgImage;
}

class ListHomeButtonWidget extends StatelessWidget {
  DataAppCustomerController dataAppCustomerController = Get.find();
  CustomerConfigController configController = Get.find();

  var WIDTH_BUTTON = 80;

  @override
  Widget build(BuildContext context) {
    bool isScroll = configController.configApp.isScrollButton ?? false;

    var listButtons;
    if (dataAppCustomerController.homeData.value.listLayout != null) {
      var button = dataAppCustomerController.homeData.value.listLayout
          ?.firstWhereOrNull((element) => element.model == 'HomeButton');

      if (button != null) {
        listButtons = [...button.list!.cast<HomeButton>()];
      }
    }

    return listButtons == null || listButtons.length == 0
        ? Container()
        : isScroll
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Container(
                  width: Get.width,
                  height: 90,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listButtons.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            ActionTap.onTap(
                                typeAction: listButtons[index].typeAction,
                                value: listButtons[index].value);
                          },
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: HomeButtonWidget(listButtons[index]),
                            ),
                          ),
                        );
                      }),

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: listButtons
                  //         .map<Widget>(
                  //           (pos) => InkWell(
                  //             onTap: () {
                  //               ActionTap.onTap(
                  //                   typeAction: pos.typeAction,
                  //                   value: pos.value);
                  //             },
                  //             child: Center(
                  //               child: Padding(
                  //                 padding: const EdgeInsets.only(
                  //                     left: 8.0, right: 8.0),
                  //                 child: HomeButtonWidget(pos),
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //         .toList(),
                  //   ),
                  // ),
                ),
              )
            : new StaggeredGridView.countBuilder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: true,
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                itemBuilder: (context, pos) {
                  var homeButton = listButtons[pos];

                  return InkWell(
                    onTap: () {
                      ActionTap.onTap(
                          typeAction: listButtons[pos].typeAction,
                          value: listButtons[pos].value);
                    },
                    child: Center(child: HomeButtonWidget(homeButton)),
                  );
                },
                itemCount: listButtons.length,
                crossAxisCount:
                    (MediaQuery.of(context).size.width / WIDTH_BUTTON).floor(),
                mainAxisSpacing: 5,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
              );
  }
}

Widget decorationButton({required Color color, required Widget child}) {
  return Container(
    decoration: BoxDecoration(color: color.withOpacity(0.1)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: child,
    ),
  );
}

class HomeButtonWidget extends StatelessWidget {
  CustomerConfigController configController = Get.find();
  HomeButton homeButton;

  HomeButtonWidget(this.homeButton);

  @override
  Widget build(BuildContext context) {
    var buttonWidget;
    if (configController.configApp.typeButton != null &&
        configController.configApp.typeButton! <
            RepositoryWidgetCustomer().LIST_BUTTON_WIDGET.length) {
      buttonWidget = RepositoryWidgetCustomer()
          .LIST_BUTTON_WIDGET[configController.configApp.typeButton!];
    } else {
      buttonWidget = RepositoryWidgetCustomer().LIST_BUTTON_WIDGET[0];
    }
    buttonWidget.homeButton = homeButton;

    return buttonWidget;
  }
}

import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_products_widget.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/components/product_item/product_item_loading_widget.dart';
import 'package:sahashop_customer/app_customer/components/text_field/saha_text_field_search.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/category_product_style_1/search_text_field_screen/search_text_field_screen.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';

import '../../../config_controller.dart';
import '../../../model/attribute_search.dart';
import '../../../utils/debounce.dart';
import '../category_controller.dart';

// ignore: must_be_immutable
class CategoryProductStyle1 extends StatefulWidget {
  bool autoSearch;
  bool? isHideBack;

  CategoryProductStyle1({Key? key, this.autoSearch = false}) : super(key: key);

  @override
  _CategoryProductStyle1State createState() => _CategoryProductStyle1State();
}

class _CategoryProductStyle1State extends State<CategoryProductStyle1> {
  final CustomerConfigController configController = Get.find();

  final DataAppCustomerController dataAppCustomerController = Get.find();

  CategoryController categoryController1 = new CategoryController();

  ScrollController _scrollController = new ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          categoryController1.isLoadingProductMore.value != true) {
        categoryController1.searchProduct();
      }
    });
  }

  void onSearch() {
    Get.to(SearchTextFiledScreen(
      onSubmit: (text, categoryId) {
        categoryController1.textEditingControllerSearch.text = text!;
        categoryController1.searchProduct(search: text,isRefresh: true);
      },
    ));
  }

  double height = AppBar().preferredSize.height;
  var index = 1;
  @override
  Widget build(BuildContext context) {
    ////  ////  ////  ////  ////  ////
    return Scaffold(
      backgroundColor: Colors.grey[300],
      key: _scaffoldKey,
      onEndDrawerChanged: (v) {
        if (v == false && index == 1) {
          categoryController1.searchProduct(
              sortBy: categoryController1.sortByCurrent,isRefresh: true);
          index++;
        }
      },
      endDrawer: Drawer(
        child: Container(
          width: Get.width / 2,
          height: Get.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Bộ lọc tìm kiếm",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                      ),
                      Text("Sản phẩm"),
                      Container(
                        height: 40,
                        margin: EdgeInsets.all(10),
                        child: Obx(
                          () => FilterChip(
                            label: Text(
                              "Giảm giá",
                              style: TextStyle(fontSize: 13),
                            ),
                            selected:
                                categoryController1.isChooseDiscountSort.value,
                            backgroundColor: Colors.transparent,
                            shape: StadiumBorder(
                                side: BorderSide(color: Colors.grey[300]!)),
                            onSelected: (bool value) {
                              categoryController1.isChooseDiscountSort.value =
                                  !categoryController1
                                      .isChooseDiscountSort.value;
                            },
                          ),
                        ),
                      ),
                      Obx(() => Column(
                            children: [
                              ...categoryController1.listAttributeSearch
                                  .map((e) => attriButeSearchItem(e))
                                  .toList(),
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: widget.isHideBack == true ? false : true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).primaryTextTheme.displayLarge!.color,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SahaTextFieldSearch(
                    textEditingController:
                        categoryController1.textEditingControllerSearch,
                    onChanged: (v) {
                      print(v);
                      EasyDebounce.debounce('category_product_screen',
                          Duration(milliseconds: 500), () {
                        print(v);
                        categoryController1.searchProduct(search: v,isRefresh: true);
                      });
                    },
                    onClose: () {
                      categoryController1.searchProduct(search: "",isRefresh: true);
                    },
                  )),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
              index = 1;
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 10.0),
              child: Obx(
                () => Icon(
                  categoryController1.listAttributeSearchChoose.isNotEmpty ||
                          categoryController1.isChooseDiscountSort.value == true
                      ? Icons.filter_alt_rounded
                      : Icons.filter_alt_outlined,
                  color: categoryController1
                              .listAttributeSearchChoose.isNotEmpty ||
                          categoryController1.isChooseDiscountSort.value == true
                      ? Colors.blue
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: buildItemOrderBy(title: "Phổ biến", key: "views")),
                Expanded(
                    child:
                        buildItemOrderBy(title: "Mới nhất", key: "created_at")),
                Expanded(
                    child: buildItemOrderBy(title: "Bán chạy", key: "sales")),
                Expanded(child: buildItemOrderBy(title: "Giá", key: "price")),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  categoryController1.isLoadingCategory.value
                      ? SahaLoadingWidget(
                          size: 70,
                        )
                      : Container(
                          width: 70,
                          color: Colors.white.withOpacity(0.8),
                          child: ListView.builder(
                              itemCount: categoryController1.categories.length,
                              itemBuilder: (context, index) {
                                return buildItem(
                                    category:
                                        categoryController1.categories[index]);
                              }),
                        ),
                  Expanded(child: buildList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget attriButeSearchItem(AttributeSearch attributeSearch) {
     var isLoadMore =
        (attributeSearch.productAttributeSearchChildren ?? []).length > 4
            ? false.obs
            : true.obs;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          Text(
            attributeSearch.name ?? '',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Obx(
            ()=> Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children:  (isLoadMore == false
                          ? (attributeSearch.productAttributeSearchChildren ??
                                  [])
                              .sublist(0, 4)
                          : (attributeSearch.productAttributeSearchChildren ??
                              []))
                      .map((e) => Container(
                            height: 40,
                            margin: EdgeInsets.all(10),
                            child: Obx(
                              () => FilterChip(
                                checkmarkColor: Colors.green,
                                selectedColor: Colors.white,
                                shadowColor: Colors.grey,
                                label: Text(
                                  e.name ?? '',
                                  style: TextStyle(fontSize: 13),
                                ),
                                selected: categoryController1
                                    .listAttributeSearchChoose
                                    .map((e) => e.id)
                                    .contains(e.id),
                                backgroundColor: Colors.transparent,
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.grey[300]!)),
                                onSelected: (bool value) {
                                  if (categoryController1.listAttributeSearchChoose
                                      .map((e) => e.id)
                                      .contains(e.id)) {
                                    categoryController1.listAttributeSearchChoose
                                        .removeWhere((x) => x.id == e.id);
                                  } else {
                                    categoryController1.listAttributeSearchChoose
                                        .add(e);
                                  }
                                },
                              ),
                            ),
                          ))
                      .toList(),
                ),
                 if ((attributeSearch.productAttributeSearchChildren ?? [])
                        .length >
                    4)
                  TextButton(
                      onPressed: () {
                        isLoadMore.value = !isLoadMore.value;
                      },
                      child: Text(isLoadMore.value == false
                          ? "Xem thêm >>"
                          : "Thu gọn"))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemOrderBy({String? title, String? key, Function? onTap}) {
    return Obx(
      () {
        bool? selected = key == categoryController1.sortByShow.value;

        return InkWell(
          onTap: () {
            if (categoryController1.sortByShow.value == "price" &&
                key == "price") {
              categoryController1.searchProduct(
                  sortBy: key,
                  descending: !categoryController1.descendingShow.value,isRefresh: true);
              return;
            }
            categoryController1.searchProduct(sortBy: key,isRefresh: true);
          },
          child: Row(
            children: [
              selected
                  ? VerticalDivider(
                      color: Colors.grey,
                      width: 1,
                    )
                  : Container(),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(title ?? ""),
                          ),
                          key == "price" && selected
                              ? (Transform.rotate(
                                  angle:
                                      (!categoryController1.descendingShow.value
                                              ? -90
                                              : 90) *
                                          math.pi /
                                          180,
                                  child: Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: SahaColorUtils()
                                        .colorPrimaryTextWithWhiteBackground(),
                                  ),
                                ))
                              : Container()
                        ],
                      ),
                      Container(
                        height: 2,
                        color: selected
                            ? SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground()
                            : null,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              selected
                  ? VerticalDivider(
                      color: Colors.grey,
                      width: 1,
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  Widget buildList() {
    return Obx(() {
      var isLoading = categoryController1.isLoadingProduct.value;
      var list = categoryController1.products;
      return Padding(
        padding: const EdgeInsets.all(2.5),
        child: isLoading
            ? StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) =>
                    ProductItemLoadingWidget(),
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              )
            : list.length == 0
                ? SahaEmptyProducts()
                : Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (categoryController1.isChooseDiscountSort.value)
                            Container(
                              height: 40,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Obx(
                                () => FilterChip(
                                  label: Text(
                                    "Giảm giá",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  selected: categoryController1
                                      .isChooseDiscountSort.value,
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(
                                      side:
                                          BorderSide(color: Colors.grey[300]!)),
                                  onSelected: (bool value) {
                                    categoryController1
                                            .isChooseDiscountSort.value =
                                        !categoryController1
                                            .isChooseDiscountSort.value;
                                    if (categoryController1
                                            .isChooseDiscountSort.value ==
                                        false) {
                                      categoryController1.searchProduct(
                                          sortBy: categoryController1
                                              .sortByCurrent,isRefresh: true);
                                    }
                                  },
                                ),
                              ),
                            ),
                          Expanded(
                            child: StaggeredGridView.countBuilder(
                              crossAxisCount: 2,
                              itemCount: list.length,
                              controller: _scrollController,
                              itemBuilder: (BuildContext context, int index) =>
                                  ProductItemWidget(
                                product: list[index],
                                showCart: false,
                              ),
                              staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.fit(1),
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                      categoryController1.isLoadingProductMore.value
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: CupertinoActivityIndicator(),
                            )
                          : Container()
                    ],
                  ),
      );
    });
  }

  Widget buildItem({Category? category}) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                width: categoryController1.categoryCurrent.value == category!.id
                    ? 4
                    : 0),
            right: BorderSide(color: Colors.grey, width: 0.5),
            bottom: BorderSide(color: Colors.grey, width: 0.5),
          ),
          color: categoryController1.categoryCurrent.value == category.id
              ? SahaColorUtils().colorTextWithPrimaryColor()
              : null,
        ),
        child: InkWell(
          onTap: () {
            categoryController1.setCategoryCurrent(category);

            categoryController1.searchProduct(idCategory: category.id,isRefresh: true);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                child: category.id == null
                    ? SvgPicture.asset(
                        "packages/sahashop_customer/assets/svg/all.svg",
                        color: SahaColorUtils()
                            .colorPrimaryTextWithWhiteBackground(),
                        width: 25.0,
                        height: 25.0,
                      )
                    : CachedNetworkImage(
                        imageUrl: category.imageUrl ?? "",
                        imageBuilder: (context, imageProvider) => Container(
                          padding: EdgeInsets.all(20),
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => SahaLoadingContainer(),
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                category.name!,
                maxLines: 3,
                style: TextStyle(
                    fontSize: 13,
                    color: categoryController1.categoryCurrent.value == category
                        ? SahaColorUtils().colorPrimaryTextWithWhiteBackground()
                        : Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

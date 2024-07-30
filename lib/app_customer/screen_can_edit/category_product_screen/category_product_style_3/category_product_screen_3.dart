import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_products_widget.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/components/product_item/product_item_loading_widget.dart';
import 'package:sahashop_customer/app_customer/components/text_field/saha_text_field_search.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/category_product_style_1/search_text_field_screen/search_text_field_screen.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/debounce.dart';

import '../../../config_controller.dart';
import '../../../model/attribute_search.dart';
import '../../../model/product.dart';
import '../category_controller.dart';

// ignore: must_be_immutable
class CategoryProductStyle3 extends StatefulWidget {
  bool autoSearch;
  bool? isHideBack;

  CategoryProductStyle3({Key? key, this.autoSearch = false}) : super(key: key);

  @override
  _CategoryProductStyle3State createState() => _CategoryProductStyle3State();
}

class _CategoryProductStyle3State extends State<CategoryProductStyle3> {
  final CustomerConfigController configController = Get.find();

  final DataAppCustomerController dataAppCustomerController = Get.find();

  CategoryController categoryController1 = new CategoryController();

  ScrollController _scrollController = new ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    // categoryController1.init();
  }

  void onSearch() {
    Get.to(SearchTextFiledScreen(
      onSubmit: (text, categoryId) {
        categoryController1.textEditingControllerSearch.text = text!;
        categoryController1.searchProduct(search: text);
      },
    ));
  }

  double height = AppBar().preferredSize.height;
  var index = 1;
  @override
  Widget build(BuildContext context) {
    ////  ////  ////  ////  ////  ////
    return Scaffold(
        backgroundColor: Colors.grey[200],
        key: _scaffoldKey,
        onEndDrawerChanged: (v) {
          if (v == false && index == 1) {
            categoryController1.searchProduct(
              sortBy: categoryController1.sortByCurrent,
              isRefresh: true,
            );
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                        Text(
                          "Sản phẩm",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.all(10),
                          child: Obx(
                            () => FilterChip(
                              label: Text(
                                "Giảm giá",
                                style: TextStyle(fontSize: 13),
                              ),
                              checkmarkColor: Colors.green,
                              selectedColor: Colors.white,
                              shadowColor: Colors.grey,
                              selected: categoryController1
                                  .isChooseDiscountSort.value,
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
                      ],
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
                      color: Theme.of(context)
                          .primaryTextTheme
                          .displayLarge!
                          .color,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SahaTextFieldSearch(
                      autofocus: widget.autoSearch,
                      textEditingController:
                          categoryController1.textEditingControllerSearch,
                      onChanged: (v) {
                        EasyDebounce.debounce('category_product_screen',
                            Duration(milliseconds: 500), () {
                          print(v);
                          categoryController1.searchProduct(
                              search: v, isRefresh: true);
                          categoryController1.addSearchHistory(v);
                          categoryController1.categoriesChild.refresh();
                        });
                      },
                      onClose: () {
                        categoryController1.searchProduct(
                            search: "", isRefresh: true);
                        categoryController1.histories.refresh();
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
                            categoryController1.isChooseDiscountSort.value ==
                                true
                        ? Icons.filter_alt_rounded
                        : Icons.filter_alt_outlined,
                    color: categoryController1
                                .listAttributeSearchChoose.isNotEmpty ||
                            categoryController1.isChooseDiscountSort.value ==
                                true
                        ? Colors.blue
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: NestedScrollView(
          controller: _scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              Obx(
                () => SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: true,
                  expandedHeight: checkHeight(),
                  collapsedHeight: checkHeight(),
                  backgroundColor: Colors.white,
                  forceElevated: innerBoxIsScrolled,
                  iconTheme: IconThemeData(color: Colors.transparent),
                  actions: [],
                  flexibleSpace: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (categoryController1
                              .textEditingControllerSearch.text.isEmpty &&
                          categoryController1.histories.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoryController1.histories
                                .map((e) => InkWell(
                                      onTap: () {
                                        categoryController1.searchProduct(
                                            search: e.text, isRefresh: true);
                                        categoryController1
                                            .textEditingControllerSearch
                                            .text = e.text ?? '';
                                        categoryController1
                                                .textEditingControllerSearch
                                                .selection =
                                            TextSelection.fromPosition(TextPosition(
                                                offset: categoryController1
                                                    .textEditingControllerSearch
                                                    .text
                                                    .length));
                                        categoryController1.histories.refresh();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(3, 3),
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(0.16),
                                                spreadRadius: -2,
                                              )
                                            ]),
                                        child: Text(e.text ?? ''),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: buildItemOrderBy(
                                  title: "Phổ biến", key: "views")),
                          Expanded(
                              child: buildItemOrderBy(
                                  title: "Mới nhất", key: "created_at")),
                          Expanded(
                              child: buildItemOrderBy(
                                  title: "Bán chạy", key: "sales")),
                          Expanded(
                              child:
                                  buildItemOrderBy(title: "Giá", key: "price")),
                        ],
                      ),
                      Obx(
                        ()=>Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 70,
                                // width: Get.width,
                                color: Colors.white.withOpacity(0.8),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        categoryController1.categories.length,
                                    itemBuilder: (context, index) {
                                      return buildItem(
                                          category: categoryController1
                                              .categories[index]);
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (categoryController1.categoriesChild.isNotEmpty)
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60,
                                // width: Get.width,
                                color: Colors.white.withOpacity(0.8),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categoryController1
                                        .categoriesChild.length,
                                    itemBuilder: (context, index) {
                                      return buildItemChild(
                                          category: categoryController1
                                              .categoriesChild[index]);
                                    }),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: buildList(),
        ));
  }

  double checkHeight() {
    if (categoryController1.textEditingControllerSearch.text.isEmpty &&
        categoryController1.histories.isNotEmpty) {
      return categoryController1.categoriesChild.isNotEmpty ? 230 : 170;
    } else {
      return categoryController1.categoriesChild.isNotEmpty ? 170 : 110;
    }
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
                  isRefresh: true,
                  descending: !categoryController1.descendingShow.value);
              return;
            }
            categoryController1.searchProduct(
              sortBy: key,
              isRefresh: true,
            );
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
    return Column(
      children: [
        SizedBox(
          height: 3,
        ),
        Expanded(
          child: Obx(() {
            // var isLoading = ;
            // var list = ;
            return categoryController1.isLoadingProduct.value
                ? StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) =>
                        ProductItemLoadingWidget(),
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(1),
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  )
                : categoryController1.products.isEmpty
                    ? SahaEmptyProducts()
                    : SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        header: MaterialClassicHeader(),
                        onRefresh: () async {
                          await categoryController1.searchProduct(
                              isRefresh: true);
                          refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await categoryController1.searchProduct();

                          refreshController.loadComplete();
                        },
                        footer: CustomFooter(
                          builder: (
                            BuildContext context,
                            LoadStatus? mode,
                          ) {
                            Widget body = Container();
                            if (mode == LoadStatus.idle) {
                              body = categoryController1.isLoadingProduct.value
                                  ? CupertinoActivityIndicator()
                                  : Container();
                            } else if (mode == LoadStatus.loading) {
                              body = CupertinoActivityIndicator();
                            }
                            return Container(
                              height: 100,
                              child: Center(child: body),
                            );
                          },
                        ),
                        controller: refreshController,
                        child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemCount: (categoryController1.products.length / 2).ceil(),
                            itemBuilder: (BuildContext context, int index) {
                              var length = categoryController1.products.length;
                              var index1 = index * 2;

                              return itemProduct(
                                  motelPost1: categoryController1.products[index1],
                                  motelPost2: length <= (index1 + 1)
                                      ? null
                                      : categoryController1.products[index1 + 1]);
                            }),
                      );
          }),
        ),
      ],
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
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: (isLoadMore == false
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
                                  if (categoryController1
                                      .listAttributeSearchChoose
                                      .map((e) => e.id)
                                      .contains(e.id)) {
                                    categoryController1
                                        .listAttributeSearchChoose
                                        .removeWhere((x) => x.id == e.id);
                                  } else {
                                    categoryController1
                                        .listAttributeSearchChoose
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

  Widget buildItem({Category? category}) {
    return Obx(
      () => Container(
        width: 80,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                width: categoryController1.categoryCurrent.value == category!.id
                    ? 2
                    : 0),
            right: BorderSide(color: Colors.grey, width: 0.5),
            left: BorderSide(color: Colors.grey, width: 0.5),
          ),
          color: categoryController1.categoryCurrent.value == category.id
              ? Colors.white
              : null,
        ),
        child: InkWell(
          onTap: () {
            categoryController1.setCategoryCurrent(category);

            categoryController1.searchProduct(
              idCategory: category.id,
              isRefresh: true,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: category.id == -1
                      ? Center(
                          child: SvgPicture.asset(
                            "packages/sahashop_customer/assets/svg/all.svg",
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                            width: 35.0,
                            height: 35.0,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: category.imageUrl ?? "",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              SahaEmptyImage(),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Text(
                category.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    color: categoryController1.categoryCurrent.value ==
                            category.id
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

  Widget buildItemChild({Category? category}) {
    return Obx(
      () => Container(
        width: 70,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                width: categoryController1.categoryCurrentChild.value ==
                        category!.id
                    ? 2
                    : 0),
            right: BorderSide(color: Colors.grey, width: 0.5),
            left: BorderSide(color: Colors.grey, width: 0.5),
          ),
          color: categoryController1.categoryCurrentChild.value == category.id
              ? Colors.white
              : null,
        ),
        child: InkWell(
          onTap: () {
            categoryController1.setCategoryCurrentChild(category);

            categoryController1.searchProduct(
              idCategory: category.id,
              isRefresh: true,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: category.id == null
                    ? Center(
                        child: SvgPicture.asset(
                          "packages/sahashop_customer/assets/svg/all.svg",
                          color: SahaColorUtils()
                              .colorPrimaryTextWithWhiteBackground(),
                          width: 20.0,
                          height: 20.0,
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: category.imageUrl ?? "",
                        imageBuilder: (context, imageProvider) => Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => SahaLoadingWidget(
                          size: 20,
                        ),
                        errorWidget: (context, url, error) => SahaEmptyImage(
                          height: 20,
                          width: 20,
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
              Text(
                category.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
                    color: categoryController1.categoryCurrentChild.value ==
                            category.id
                        ? SahaColorUtils().colorPrimaryTextWithWhiteBackground()
                        : Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProduct({
    required Product motelPost1,
    required Product? motelPost2,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Row(
        children: [
          ProductItemWidget(
            product: motelPost1,
            width: (Get.width - 10) / 2,
            showCart: false,
            //height: 320,
          ),
          if (motelPost2 != null)
            ProductItemWidget(
              product: motelPost2,
              width: (Get.width - 10) / 2,
              showCart: false,
              //height: 320,
            ),
        ],
      ),
    );
  }
}

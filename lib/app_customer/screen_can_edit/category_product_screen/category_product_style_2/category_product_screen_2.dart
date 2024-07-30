import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/text_field/saha_text_field_search.dart';
import 'package:sahashop_customer/app_customer/model/attribute_search.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_item_widget/product_item_widget.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/empty/saha_empty_products_widget.dart';
import '../../../components/product_item/product_item_loading_widget.dart';
import '../../../config_controller.dart';
import '../../../model/product.dart';
import '../../../screen_default/data_app_controller.dart';
import '../../../utils/debounce.dart';
import '../category_controller.dart';
import 'search_text_field_screen/search_text_field_screen.dart';

class CategoryProductStyle2 extends StatefulWidget {
  bool autoSearch;
  bool? isHideBack;

  CategoryProductStyle2({Key? key, this.autoSearch = false}) : super(key: key);

  @override
  _CategoryProductStyle2State createState() => _CategoryProductStyle2State();
}

class _CategoryProductStyle2State extends State<CategoryProductStyle2> {
  final CustomerConfigController configController = Get.find();

  final DataAppCustomerController dataAppCustomerController = Get.find();

  CategoryController categoryController2 = new CategoryController();
  RefreshController refreshController = RefreshController();
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels >=
    //           _scrollController.position.maxScrollExtent &&
    //       categoryController2.isLoadingProductMore.value != true) {
    //     categoryController2.searchProduct(isLoadMore: true);
    //   }
    //   if (_scrollController.position.userScrollDirection ==
    //       ScrollDirection.reverse) {
    //     if (categoryController2.isDown.value == false) {
    //       categoryController2.isDown.value = true;
    //     }
    //   } else if (_scrollController.position.userScrollDirection ==
    //       ScrollDirection.forward) {
    //     if (categoryController2.isDown.value == true) {
    //       categoryController2.isDown.value = false;
    //     }
    //   }
    // });
    //categoryController2.init();
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   if (widget.autoSearch) {
    //     onSearch();
    //   }
    // });
  }

  void onSearch() {
    Get.to(SearchTextFiledScreen(
      onSubmit: (text, categoryId) {
        categoryController2.textEditingControllerSearch.text = text!;
        categoryController2.searchProduct(search: text);
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
            categoryController2.searchProduct(
                sortBy: categoryController2.sortByCurrent,isRefresh: true);
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
                              selected: categoryController2
                                  .isChooseDiscountSort.value,
                              backgroundColor: Colors.transparent,
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.grey[300]!)),
                              onSelected: (bool value) {
                                categoryController2.isChooseDiscountSort.value =
                                    !categoryController2
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
                          ...categoryController2.listAttributeSearch
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
                          categoryController2.textEditingControllerSearch,
                      onChanged: (v) {
                        EasyDebounce.debounce('category_product_screen',
                            Duration(milliseconds: 500), () {
                          print(v);
                          categoryController2.searchProduct(search: v,isRefresh: true);
                          categoryController2.addSearchHistory(v);
                          categoryController2.categoriesChild.refresh();
                        });
                      },
                      onClose: () {
                        categoryController2.searchProduct(search: "",isRefresh: true);
                        categoryController2.histories.refresh();
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
                    categoryController2.listAttributeSearchChoose.isNotEmpty ||
                            categoryController2.isChooseDiscountSort.value ==
                                true
                        ? Icons.filter_alt_rounded
                        : Icons.filter_alt_outlined,
                    color: categoryController2
                                .listAttributeSearchChoose.isNotEmpty ||
                            categoryController2.isChooseDiscountSort.value ==
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
                  flexibleSpace: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (categoryController2
                              .textEditingControllerSearch.text.isEmpty &&
                          categoryController2.histories.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoryController2.histories
                                .map((e) => InkWell(
                                      onTap: () {
                                        categoryController2.searchProduct(
                                            search: e.text,isRefresh: true);
                                        categoryController2
                                            .textEditingControllerSearch
                                            .text = e.text ?? '';
                                        categoryController2
                                                .textEditingControllerSearch
                                                .selection =
                                            TextSelection.fromPosition(TextPosition(
                                                offset: categoryController2
                                                    .textEditingControllerSearch
                                                    .text
                                                    .length));
                                        categoryController2.histories.refresh();
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
                        children: [
                          Expanded(
                            child: Container(
                              height: 70,
                              // width: Get.width,
                              color: Colors.white.withOpacity(0.8),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      categoryController2.categories.length,
                                  itemBuilder: (context, index) {
                                    return buildItem(
                                        category: categoryController2
                                            .categories[index]);
                                  }),
                            ),
                          ),
                        ],
                      ),
                      if (categoryController2.categoriesChild.isNotEmpty)
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60,
                                // width: Get.width,
                                color: Colors.white.withOpacity(0.8),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categoryController2
                                        .categoriesChild.length,
                                    itemBuilder: (context, index) {
                                      return buildItemChild(
                                          category: categoryController2
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
          body: Row(
            children: [
              Container(
                width: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child:
                            buildItemOrderBy(title: "Phổ biến", key: "views")),
                    Divider(
                      height: 1,
                    ),
                    Expanded(
                        child: buildItemOrderBy(
                            title: "Mới nhất", key: "created_at")),
                    Divider(
                      height: 1,
                    ),
                    Expanded(
                        child:
                            buildItemOrderBy(title: "Bán chạy", key: "sales")),
                    Divider(
                      height: 1,
                    ),
                    Expanded(
                        child: buildItemOrderBy(title: "Giá", key: "price")),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
              ),
              Expanded(child: buildList()),
            ],
          ),
        ));
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
                                selected: categoryController2
                                    .listAttributeSearchChoose
                                    .map((e) => e.id)
                                    .contains(e.id),
                                backgroundColor: Colors.transparent,
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.grey[300]!)),
                                onSelected: (bool value) {
                                  if (categoryController2.listAttributeSearchChoose
                                      .map((e) => e.id)
                                      .contains(e.id)) {
                                    categoryController2.listAttributeSearchChoose
                                        .removeWhere((x) => x.id == e.id);
                                  } else {
                                    categoryController2.listAttributeSearchChoose
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

  double checkHeight() {
    if (categoryController2.textEditingControllerSearch.text.isEmpty &&
        categoryController2.histories.isNotEmpty) {
      return categoryController2.categoriesChild.isNotEmpty ? 190 : 130;
    } else {
      return categoryController2.categoriesChild.isNotEmpty ? 130 : 70;
    }
  }

  Widget buildItemOrderBy({String? title, String? key, Function? onTap}) {
    return Obx(
      () {
        bool? selected = key == categoryController2.sortByShow.value;

        return InkWell(
          onTap: () {
            if (categoryController2.sortByShow.value == "price" &&
                key == "price") {
              categoryController2.searchProduct(
                  sortBy: key,
                  isRefresh: true,
                  descending: !categoryController2.descendingShow.value);
              return;
            }
            categoryController2.searchProduct(sortBy: key, isRefresh: true,);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                title ?? "",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            key == "price" && selected
                                ? (Transform.rotate(
                                    angle: (!categoryController2
                                                .descendingShow.value
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
                      ),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: selected
                            ? SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground()
                            : null,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [],
                        ),
                      ),
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
            var isLoading = categoryController2.isLoadingProduct.value;
            var list = categoryController2.products;
            return isLoading
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
                : list.isEmpty
                    ? SahaEmptyProducts()
                    : SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        header: MaterialClassicHeader(),
                        onRefresh: () async {
                          await categoryController2.searchProduct(isRefresh: true);
                          refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await categoryController2.searchProduct(
                          );
                          // await findRoomLoginController.getAllRoomPost();
                          refreshController.loadComplete();
                        },
                        footer: CustomFooter(
                          builder: (
                            BuildContext context,
                            LoadStatus? mode,
                          ) {
                            Widget body = Container();
                            if (mode == LoadStatus.idle) {
                              body = isLoading
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
                            itemCount: (list.length / 2).ceil(),
                            itemBuilder: (BuildContext context, int index) {
                              var length = list.length;
                              var index1 = index * 2;

                              return itemProduct(
                                  motelPost1: list[index1],
                                  motelPost2: length <= (index1 + 1)
                                      ? null
                                      : list[index1 + 1]);
                            }),
                      );
            
          }),
        ),
      ],
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
                width: categoryController2.categoryCurrent.value == category!.id
                    ? 2
                    : 0),
            right: BorderSide(color: Colors.grey, width: 0.5),
            left: BorderSide(color: Colors.grey, width: 0.5),
          ),
          color: categoryController2.categoryCurrent.value == category.id
              ? Colors.white
              : null,
        ),
        child: InkWell(
          onTap: () {
            categoryController2.setCategoryCurrent(category);

            categoryController2.searchProduct(idCategory: category.id, isRefresh: true,);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: category.id == null
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
                    color: categoryController2.categoryCurrent.value ==
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
                width: categoryController2.categoryCurrentChild.value ==
                        category!.id
                    ? 2
                    : 0),
            right: BorderSide(color: Colors.grey, width: 0.5),
            left: BorderSide(color: Colors.grey, width: 0.5),
          ),
          color: categoryController2.categoryCurrentChild.value == category.id
              ? Colors.white
              : null,
        ),
        child: InkWell(
          onTap: () {
            categoryController2.setCategoryCurrentChild(category);

            categoryController2.searchProduct(idCategory: category.id, isRefresh: true,);
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
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
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
                    color: categoryController2.categoryCurrentChild.value ==
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
            width: (Get.width - 60) / 2,
            showCart: false,
          ),
          if (motelPost2 != null)
            ProductItemWidget(
              product: motelPost2,
              width: (Get.width - 60) / 2,
              showCart: false,
            ),
        ],
      ),
    );
  }
}

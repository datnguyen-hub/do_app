import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../components/empty/saha_empty_image.dart';
import '../../../../components/empty/saha_empty_products_widget.dart';
import '../../../../components/product_item/product_item_loading_widget.dart';
import '../../../../components/text_field/saha_text_field_search.dart';
import '../../../../config_controller.dart';
import '../../../../model/attribute_search.dart';
import '../../../../model/category.dart';
import '../../../../model/product.dart';
import '../../../../screen_default/data_app_controller.dart';
import '../../../../utils/color_utils.dart';
import '../../../../utils/debounce.dart';
import '../../../product_item_widget/product_item_widget.dart';
import 'search_controller.dart';

class SearchScreen extends StatefulWidget {
  bool autoSearch;

  String? textSearchInput;
  int? categoryId;
  int? categoryChildId;
  List<Category>? categoryChildInput;
  SearchScreen(
      {Key? key,
      this.autoSearch = false,
      this.categoryId,
      this.categoryChildId,
      this.textSearchInput,
      this.categoryChildInput})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final CustomerConfigController configController = Get.find();

  final DataAppCustomerController dataAppCustomerController = Get.find();

  late SearchDataController categoryController2;
  RefreshController refreshController = RefreshController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController textEditingControllerSearch = TextEditingController();
  @override
  void initState() {
    super.initState();
    print("=========><${widget.textSearchInput ?? ""}");
    textEditingControllerSearch.text = widget.textSearchInput ?? "";
    categoryController2 = SearchDataController(
        categoryId: widget.categoryId,
        categoryChildId: widget.categoryChildId,
        textSearchInput: widget.textSearchInput,
        categoryChildInput: widget.categoryChildInput);
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
  }

  double height = AppBar().preferredSize.height;
  var index = 1;
  var sublist;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      onEndDrawerChanged: (v) {
        if (v == false && index == 1) {
          categoryController2.searchProduct(
              sortBy: categoryController2.sortByCurrent);
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
                            selected:
                                categoryController2.isChooseDiscountSort.value,
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
                      Obx(() => Column(
                            children: [
                              ...categoryController2.listAttributeSearch
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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        elevation: 0,
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
                    autofocus: widget.autoSearch,
                    textEditingController: textEditingControllerSearch,
                    onChanged: (v) {
                      EasyDebounce.debounce('category_product_screen',
                          Duration(milliseconds: 500), () {
                        print(v);
                        categoryController2.searchProduct(search: v,);
                        categoryController2.addSearchHistory(v);
                        categoryController2.categoriesChild.refresh();
                      });
                    },
                    onClose: () {
                      categoryController2.searchProduct(search: "");
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
              child: Obx(() => Icon(
                    Icons.filter_alt_rounded,
                    color: categoryController2
                                .listAttributeSearchChoose.isNotEmpty ||
                            categoryController2.isChooseDiscountSort.value ==
                                true
                        ? Colors.red
                        : null,
                  )),
            ),
          ),
        ],
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Get.width,
            color: Colors.white,
            child: Obx(() => (categoryController2
                        .textEditingControllerSearch.text.isEmpty &&
                    categoryController2.histories.isNotEmpty)
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categoryController2.histories
                          .map((e) => InkWell(
                                onTap: () {
                                  categoryController2.searchProduct(
                                      search: e.text);
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
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(3, 3),
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.16),
                                          spreadRadius: -2,
                                        )
                                      ]),
                                  child: Text(e.text ?? ''),
                                ),
                              ))
                          .toList(),
                    ),
                  )
                : Container()),
          ),
          Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: buildItemOrderBy(title: "Phổ biến", key: "views")),
                Divider(
                  height: 1,
                ),
                Expanded(
                    child:
                        buildItemOrderBy(title: "Mới nhất", key: "created_at")),
                Divider(
                  height: 1,
                ),
                Expanded(
                    child: buildItemOrderBy(title: "Bán chạy", key: "sales")),
                Divider(
                  height: 1,
                ),
                Expanded(child: buildItemOrderBy(title: "Giá", key: "price")),
                Divider(
                  height: 1,
                ),
              ],
            ),
          ),
          Expanded(child: buildList()),
        ],
      ),
    );
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
                  descending: !categoryController2.descendingShow.value);
              return;
            }
            categoryController2.searchProduct(sortBy: key);
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
                        child: Row(
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
                          await categoryController2.searchProduct();
                          refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await categoryController2.searchProduct(
                              isLoadMore: true);
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

            categoryController2.searchProduct(idCategory: category.id);
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

            categoryController2.searchProduct(idCategory: category.id);
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
            height:
                dataAppCustomerController.infoCustomer.value.isCollaborator ==
                            true ||
                        dataAppCustomerController.infoCustomer.value.isAgency ==
                            true
                    ? 330
                    : 300,
            width: (Get.width - 10) / 2,
            showCart: false,
          ),
          if (motelPost2 != null)
            ProductItemWidget(
              product: motelPost2,
              height: dataAppCustomerController
                              .infoCustomer.value.isCollaborator ==
                          true ||
                      dataAppCustomerController.infoCustomer.value.isAgency ==
                          true
                  ? 330
                  : 300,
              width: (Get.width - 10) / 2,
              showCart: false,
            ),
        ],
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
                                selected: categoryController2
                                    .listAttributeSearchChoose
                                    .map((e) => e.id)
                                    .contains(e.id),
                                backgroundColor: Colors.transparent,
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.grey[300]!)),
                                onSelected: (bool value) {
                                  if (categoryController2
                                      .listAttributeSearchChoose
                                      .map((e) => e.id)
                                      .contains(e.id)) {
                                    categoryController2
                                        .listAttributeSearchChoose
                                        .removeWhere((x) => x.id == e.id);
                                  } else {
                                    categoryController2
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
}

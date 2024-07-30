import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../components/empty/saha_empty_image.dart';
import '../../../components/empty/saha_empty_products_widget.dart';
import '../../../components/loading/loading_widget.dart';
import '../../../components/product_item/product_item_loading_widget.dart';
import '../../../components/text_field/saha_text_field_search.dart';
import '../../../config_controller.dart';
import '../../../model/attribute_search.dart';
import '../../../model/category.dart';
import '../../../model/product.dart';
import '../../../screen_can_edit/product_item_widget/product_item_widget.dart';
import '../../../screen_default/data_app_controller.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/debounce.dart';
import '../category_controller.dart';
import 'search/search_screen.dart';

class CategoryProductStyle4 extends StatefulWidget {
  bool autoSearch;
  bool? isHideBack;
  int? categoryId;
  int? categoryChildId;
  String? textSearch;
  List<Category>? categoryChildInput;

  CategoryProductStyle4(
      {Key? key,
      this.autoSearch = false,
      this.isHideBack,
      this.categoryId,
      this.categoryChildId,
      this.textSearch,
      this.categoryChildInput})
      : super(key: key);

  @override
  _CategoryProductStyle4State createState() => _CategoryProductStyle4State();
}

class _CategoryProductStyle4State extends State<CategoryProductStyle4> {
  final CustomerConfigController configController = Get.find();

  final DataAppCustomerController dataAppCustomerController = Get.find();

  late CategoryController categoryController = CategoryController();

  ScrollController _scrollController = new ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print("==================>${widget.isHideBack}");
    categoryController = new CategoryController(
        textSearchInput: widget.textSearch,
        categoryChildId: widget.categoryChildId,
        categoryChildInput: widget.categoryChildInput,
        categoryId: widget.categoryId);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
            print("abcc");
            if(categoryController.isLoadingProduct.value != true){
               categoryController.searchProduct();
            }
       
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double height = AppBar().preferredSize.height;
  var index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        onEndDrawerChanged: (v) {
          if (v == false && index == 1) {
            categoryController.searchProduct(
                sortBy: categoryController.sortByCurrent);
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
                              selected:
                                  categoryController.isChooseDiscountSort.value,
                              backgroundColor: Colors.transparent,
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.grey[300]!)),
                              onSelected: (bool value) {
                                categoryController.isChooseDiscountSort.value =
                                    !categoryController
                                        .isChooseDiscountSort.value;
                              },
                            ),
                          ),
                        ),
                        Obx(() => Column(
                              children: [
                                ...categoryController.listAttributeSearch
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
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          elevation: 0,
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
                          categoryController.textEditingControllerSearch,
                      onChanged: (v) {
                        categoryController.textSearch.value = v;
                        // EasyDebounce.debounce('category_product_screen4',
                        //     Duration(milliseconds: 500), () {
                        //   print(v);
                        //   categoryController.searchProduct(search: v);
                        //   categoryController.addSearchHistory(v);
                        //   categoryController.categoriesChild.refresh();
                        // });
                      },
                      onSubmitted: (v) {
                        if (v.isNotEmpty)
                          Get.to(() => SearchScreen(
                              autoSearch: true, textSearchInput: v));

                        // controller.textSearchSuggest.value = v;
                        //
                        // controller.addSearchHistory(v);
                      },
                      onClose: () {
                        categoryController.searchProduct(search: "", isRefresh: true,);
                        categoryController.histories.refresh();
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
                    categoryController.listAttributeSearchChoose.isNotEmpty ||
                            categoryController.isChooseDiscountSort.value ==
                                true
                        ? Icons.filter_alt_rounded
                        : Icons.filter_alt_outlined,
                    color: categoryController
                                .listAttributeSearchChoose.isNotEmpty ||
                            categoryController.isChooseDiscountSort.value ==
                                true
                        ? Colors.blue
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await categoryController.searchProduct(isRefresh: true);
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              Obx(
                () => SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: true,
                  expandedHeight: checkHeight() + 50,
                  collapsedHeight: checkHeight() + 50,
                  backgroundColor: Colors.white,
                  forceElevated: false,
                  iconTheme: IconThemeData(color: Colors.transparent),
                  actions: [],
                  flexibleSpace: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      SizedBox(
                        height: 10,
                      ),
                      cateList()
                    ],
                  ),
                ),
              ),
              Obx(
                () => categoryController.products.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            var length = categoryController.products.length;
                            var index1 = index * 2;
                            return itemProduct(
                                motelPost1: categoryController.products[index1],
                                motelPost2: length <= (index1 + 1)
                                    ? null
                                    : categoryController.products[index1 + 1]);
                          },
                          childCount:
                              (categoryController.products.length / 2).ceil(),
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            SahaEmptyProducts()
                          ],
                        ), // Hiển thị loader nếu đang tải thêm dữ liệu
                      ),
              ),
              Obx(() {
                if (categoryController.isLoadingProductMore.value == true) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration:
                          const Duration(milliseconds: 500), // Thời gian cuộn
                      curve: Curves.easeOut, // Loại hình của đường cuộn
                    );
                  });
                }

                return SliverToBoxAdapter(
                  child: categoryController.isLoadingProductMore.value
                      ? Column(
                          children: [
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator()),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        )
                      : SizedBox(), // Hiển thị loader nếu đang tải thêm dữ liệu
                );
              }),
              // SliverToBoxAdapter(
              //     child: Center(
              //   child: CircularProgressIndicator(),
              // ) // Hiển thị loader nếu đang tải thêm dữ liệu
              //     ),
            ],
          ),
        ));
  }

  Widget cateList() {
    double checkHeight() {
      var cateNumber = categoryController.categories.length;
      if (cateNumber < 9) {
        return (Get.width / 4.5) + 20;
      } else {
        return ((Get.width / 4.5) + 20) * 2;
      }
    }

    double checkWidth() {
      var cateNumber = categoryController.categories.length;
      if (cateNumber < 9) {
        return cateNumber * (Get.width / 4.5) + 1;
      } else {
        var ca2 = (cateNumber / 2).ceil();
        print(cateNumber);
        print(ca2);
        print((Get.width / 4.5));
        print(ca2 * (Get.width / 4.5));
        return ca2 * (Get.width / 4.5) + 1;
      }
    }

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: categoryController.controller,
              child: Container(
                height: checkHeight(),
                width: checkWidth(),
                child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 10,
                    children: [
                      ...List.generate(categoryController.categories.length,
                          (index) {
                        var category = categoryController.categories[index];
                        return AutoScrollTag(
                          key: ValueKey(index),
                          controller: categoryController.controller,
                          index: index,
                          child: InkWell(
                            onTap: () {
                              if (widget.categoryChildInput != null) {
                                categoryController.categoryCurrentChild.value =
                                    category.id ?? -1;
                              } else {
                                categoryController.categoryCurrent.value =
                                    category.id ?? -1;
                              }
                              if (category.listCategoryChild != null &&
                                  category.listCategoryChild!.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategoryProductStyle4(
                                            textSearch: categoryController
                                                .textSearch.value,
                                            categoryChildInput:
                                                category.listCategoryChild,
                                            categoryId: category.id,
                                          )),
                                );
                              } else {
                                categoryController.searchProduct(isRefresh: true);
                              }
                            },
                            child: SizedBox(
                              width: Get.width / 4.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  category.id == -1
                                      ? SizedBox(
                                          width: Get.width / 6,
                                          height: Get.width / 6,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'packages/sahashop_customer/assets/icons/cate_home_new.svg',
                                                color: categoryController
                                                            .categoryCurrent
                                                            .value ==
                                                        category.id
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : null,
                                                width: Get.width / 9,
                                                height: Get.width / 9,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          color: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: CachedNetworkImage(
                                              width: Get.width / 6,
                                              height: Get.width / 6,
                                              fit: BoxFit.cover,
                                              imageUrl: category.imageUrl ?? "",
                                              errorWidget:
                                                  (context, url, error) =>
                                                      SahaEmptyImage(),
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 3, right: 3),
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        category.name ?? "",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: widget
                                                      .categoryChildInput !=
                                                  null
                                              ? (categoryController
                                                          .categoryCurrentChild
                                                          .value ==
                                                      category.id
                                                  ? FontWeight.bold
                                                  : null)
                                              : (categoryController
                                                          .categoryCurrent
                                                          .value ==
                                                      category.id
                                                  ? FontWeight.bold
                                                  : null),
                                          color: widget.categoryChildInput !=
                                                  null
                                              ? (categoryController
                                                          .categoryCurrentChild
                                                          .value ==
                                                      category.id
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : null)
                                              : categoryController
                                                          .categoryCurrent
                                                          .value ==
                                                      category.id
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double checkHeight() {
    double h = 1;
    var cateNumber = categoryController.categories.length;
    if (cateNumber < 9) {
      h = (Get.width / 4.5) + 20;
    } else {
      h = ((Get.width / 4.5) + 20) * 2;
    }
    return h;
  }

  Widget buildItemChild({Category? category}) {
    return Obx(
      () => Container(
        width: 70,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                width: categoryController.categoryCurrentChild.value ==
                        category!.id
                    ? 2
                    : 0),
            right: BorderSide(color: Colors.grey, width: 0.5),
            left: BorderSide(color: Colors.grey, width: 0.5),
          ),
          color: categoryController.categoryCurrentChild.value == category.id
              ? Colors.white
              : null,
        ),
        child: InkWell(
          onTap: () {
            categoryController.setCategoryCurrentChild(category);

            categoryController.searchProduct(idCategory: category.id, isRefresh: true,);
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
                    color: categoryController.categoryCurrentChild.value ==
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

  Widget buildItemOrderBy({String? title, String? key, Function? onTap}) {
    return Obx(
      () {
        bool? selected = key == categoryController.sortByShow.value;

        return InkWell(
          onTap: () {
            if (categoryController.sortByShow.value == "price" &&
                key == "price") {
              categoryController.searchProduct(
                  sortBy: key,
                   isRefresh: true,
                  descending: !categoryController.descendingShow.value);
              return;
            }
            categoryController.searchProduct(sortBy: key, isRefresh: true,);
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
                                      (!categoryController.descendingShow.value
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

  Widget buildItem({required Category category}) {
    return Obx(
      () => Container(
        width: Get.width / 4,
        height: 110,
        child: InkWell(
          onTap: () {
            if (widget.categoryChildInput != null) {
              categoryController.categoryCurrentChild.value = category.id ?? -1;
            } else {
              categoryController.categoryCurrent.value = category.id ?? -1;
            }
            if (category.listCategoryChild != null &&
                category.listCategoryChild!.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryProductStyle4(
                          textSearch: categoryController.textSearch.value,
                          categoryChildInput: category.listCategoryChild,
                          categoryId: category.id,
                        )),
              );
            } else {
              categoryController.searchProduct( isRefresh: true,);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 10,
                        offset: Offset(4, 7), // Shadow position
                      ),
                    ]),
                child: category.imageUrl == null
                    ? SizedBox(
                        height: 60,
                        width: 60,
                        child: category.name == 'Tất cả'
                            ? Icon(
                                Icons.view_module_rounded,
                                size: 60,
                                color: Colors.teal,
                              )
                            : SahaEmptyImage(),
                      )
                    : Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 10,
                              offset: Offset(4, 7), // Shadow position
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: category.imageUrl ?? "",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => SahaLoadingWidget(),
                          errorWidget: (context, url, error) =>
                              SahaEmptyImage(),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Container(
                width: 80,
                child: Text(
                  category.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13,
                      color: widget.categoryChildInput != null
                          ? categoryController.categoryCurrentChild.value ==
                                  category.id
                              ? Colors.blue
                              : Colors.black54
                          : categoryController.categoryCurrent.value ==
                                  category.id
                              ? Colors.blue
                              : Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
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
                                selected: categoryController
                                    .listAttributeSearchChoose
                                    .map((e) => e.id)
                                    .contains(e.id),
                                backgroundColor: Colors.transparent,
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.grey[300]!)),
                                onSelected: (bool value) {
                                  if (categoryController
                                      .listAttributeSearchChoose
                                      .map((e) => e.id)
                                      .contains(e.id)) {
                                    categoryController.listAttributeSearchChoose
                                        .removeWhere((x) => x.id == e.id);
                                  } else {
                                    categoryController.listAttributeSearchChoose
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

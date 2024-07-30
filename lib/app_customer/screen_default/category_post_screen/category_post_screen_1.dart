import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import '../../config_controller.dart';
import '../../screen_default/category_post_screen/input_model_posts.dart';
import '../../components//loading/loading_container.dart';
import '../../components/product_item/post_item_widget.dart';
import '../../screen_default/data_app_controller.dart';
import '../../components//loading/loading_widget.dart';
import '../../model/category_post.dart';

import 'controller/category_post_controller.dart';

class CategoryPostScreen extends StatelessWidget {
  final CustomerConfigController configController = Get.find();
  final DataAppCustomerController dataAppCustomerController = Get.find();
  late final CategoryPostController categoryController;

  final int? categoryId;
  bool? isAutoBackIcon;
  CategoryPostScreen({this.categoryId, this.isAutoBackIcon}) {
    dataAppCustomerController.inputModelPosts =
        InputModelPosts(categoryPostId: categoryId);
    categoryController = Get.put(CategoryPostController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tin tức"),
        automaticallyImplyLeading: isAutoBackIcon ?? false,
      ),
      body: Obx(
        () => Column(
          children: [
            Container(
              height: 45,
              child: categoryController.isLoadingCategoryPost.value
                  ? SahaLoadingWidget()
                  : Container(
                      width: Get.width,
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: categoryController.categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                buildItem(
                                    category:
                                        categoryController.categories[index]),
                              ],
                            );
                          }),
                    ),
            ),
            Expanded(child: buildList()),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return Obx(() {
      var isLoading = categoryController.isLoadingPost.value;
      List list = isLoading ? [] : categoryController.posts.toList();
      return Padding(
        padding: const EdgeInsets.all(2.5),
        child: isLoading
            ? SahaLoadingFullScreen()
            : list.isEmpty
                ? Center(
                    child: Text("Chưa có bài viết"),
                  )
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        PostItemWidget(
                      post: list[index],
                      isLoading: isLoading,
                    ),
                    itemCount: list.length,
                  ),
      );
    });
  }

  Widget buildItem({CategoryPost? category}) {
    return Obx(() => InkWell(
          onTap: () {
            categoryController.setCategoryPostCurrent(category);
          },
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color:
                      categoryController.categoryCurrent.value == category!.id
                          ? Theme.of(Get.context!).primaryColor
                          : Colors.white,
                  width: 2,
                )),
                color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5,
                ),
                category.imageUrl == null || category.imageUrl == ""
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            child: CachedNetworkImage(
                              imageUrl: category.imageUrl ?? "",
                              placeholder: (context, url) =>
                                  SahaLoadingContainer(),
                              errorWidget: (context, url, error) => Container(),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                Text(
                  "${category.title ?? ""}",
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: categoryController.categoryCurrent.value ==
                              category.id
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: categoryController.categoryCurrent.value ==
                              category.id
                          ? Theme.of(Get.context!).primaryColor
                          : Colors.black54),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ));
  }
}

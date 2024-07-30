import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/components/widget/select_image/select_images.dart';
import 'package:sahashop_customer/app_customer/screen_default/review/product_review/review_product/review_product_controller.dart';

import '../../../../components/widget/video_picker_single/video_picker_single.dart';
import '../../../../model/image_up.dart';
import '../../../../model/product.dart';
import '../../widget/select_image_review.dart';
import '../../widget/star.dart';
import '../../widget/text_field_choose.dart';


class ReviewProductScreen extends StatelessWidget {
   ReviewProductScreen({super.key,required this.product,this.orderCode}){
    controller = ReviewProductController(orderCode: orderCode);
  }
  late ReviewProductController controller ;
  final Product product;
   String? orderCode;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Đánh giá sản phẩm"),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: CachedNetworkImage(
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                      imageUrl:
                          (product.images ?? []) .isEmpty ? '' : product.images![0].imageUrl ?? '',
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                        "${product.name ?? "Loading..."}"),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Obx(
              () => Star(
                starInput: controller.review.value.stars,
                onTap: (int star) {
                  controller.review.value.stars = star;
                  controller.review.refresh();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectImages(
                type: "",
                maxImage: 10,
                title: "Chọn ảnh",
                subTitle: "Chọn tối đa 10 ảnh",
                onUpload: () {
                 // reviewController!.setUploadingImages(true);
                },
                images: controller.listImages,
                doneUpload: (List<ImageData> listImages) {
                 
                  print(
                      "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
             
                  controller.listImages.value = listImages;
                  listImages.forEach((image) {
                  //  controller.review.value.images
                  //       .add(image.linkImage!);
                  });
                 // print(controller.listImageRequest);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: 
               Obx(
                 ()=> VideoPickerSingle(
                    linkVideo: controller.review.value.videoUrl,
                    onChange: (File? file) async {
                      controller.file = file;
                      if (file == null) {
                       controller.review.value.videoUrl = null;
                      }
                    },
                  ),
               ),
           
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldChoose(
              listChooseText: controller.listChooseText,
              textInput: controller.review.value.content,
              onChange: (v) {
                controller.review.value.content = v;
             
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            )
          ],
        ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: Column(children: [
            SahaButtonFullParent(
              text: "Gửi đánh giá",
              color: Theme.of(context).primaryColor,
              onPressed: (){
                controller.reviewProduct(product.id!);
    
              },
            )
          ]),
        ),
      ),
    );
  }
}
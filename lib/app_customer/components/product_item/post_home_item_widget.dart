import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';

import '../../components/empty/saha_empty_image.dart';
import '../../model/post.dart';
import '../../screen_default/category_post_screen/read_post_screen/input_model_post.dart';
import '../../screen_default/category_post_screen/read_post_screen/read_post_screen.dart';
import '../../screen_default/data_app_controller.dart';
import '../../utils/date_utils.dart';

class PostHomeItemWidget extends StatelessWidget {
  const PostHomeItemWidget({
    Key? key,
    required this.post,
    this.isLoading = false,
    this.width,
  }) : super(key: key);

  final Post post;
  final bool isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            DataAppCustomerController dataAppCustomerController = Get.find();
            // dataAppCustomerController.toPostAllScreen();
            Get.to(() => ReadPostScreen(
                      inputModelPost: InputModelPost(post: post),
                    ))!
                .then((value) => {dataAppCustomerController.getBadge()});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                child: isLoading
                    ? Container(
                        height: 70,
                        width: 70,
                        color: Colors.black,
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                            )
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: 180,
                          width: 300,
                          fit: BoxFit.cover,
                          imageUrl: post.imageUrl == null ? "" : post.imageUrl!,
                          placeholder: (context, url) => SahaLoadingWidget(),
                          errorWidget: (context, url, error) =>
                              SahaEmptyImage(),
                        ),
                      ), //post.images[0].imageUrl,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        maxLines: 2,
                      ),
                      SizedBox(height: 3),
                      Text(
                        post.category != null && post.category!.length > 0
                            ? post.category![0].title!
                            : "",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: 3),
                      Text(
                        SahaDateUtils()
                            .getDDMMYY(post.updatedAt ?? DateTime.now()),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

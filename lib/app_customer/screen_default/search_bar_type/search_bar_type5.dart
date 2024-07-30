import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen_default/data_app_controller.dart';


// ignore: must_be_immutable
class SearchBarType5 extends StatelessWidget {
  Function? onSearch;
  DataAppCustomerController dataAppCustomerController = Get.find();
  SearchBarType5({Key? key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              onSearch == null ? null : onSearch!();
            },
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey[600],
                  ),
                  Expanded(
                    child: Text(
                      "Tìm kiếm",
                      style: TextStyle(color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../model/product.dart';

class DescriptionProduct extends StatelessWidget {
  Product product;

  DescriptionProduct({required this.product});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 8,
          color: Colors.grey[100],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Mô tả sản phẩm',
            style:
                TextStyle(fontSize: 15, color: Theme.of(context).primaryColor),
          ),
        ),
        ExpandableNotifier(
          child: ScrollOnExpand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expandable(
                  collapsed: Column(
                    children: [
                      Divider(
                        height: 1,
                      ),
                      Container(
                        height: product.description == null ? 0 : 100,
                        padding: const EdgeInsets.only(
                          right: 10.0,
                          left: 10.0,
                        ),
                        child: IgnorePointer(
                          ignoring: false,
                          child: SingleChildScrollView(
                            child: HtmlWidget(
                              product.description ?? " ",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  expanded: IgnorePointer(
                    ignoring: false,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Divider(
                            height: 1,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              left: 10.0,
                            ),
                            child: HtmlWidget(
                              product.description ?? " ",
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        var controller =
                            ExpandableController.of(context, required: false)!;
                        return Container(
                          child: TextButton(
                            child: Text(
                              controller.expanded ? "Thu gọn" : "Xem thêm",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.deepPurple),
                            ),
                            onPressed: () {
                              controller.toggle();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 8,
          color: Colors.grey[100],
        ),
        
      ],
    );
  }
}

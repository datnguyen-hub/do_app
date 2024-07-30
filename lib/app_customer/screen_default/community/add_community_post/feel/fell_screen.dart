import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/community.dart';

class EmotionsActivityScreen extends StatelessWidget {

  Function onChoose ;

  EmotionsActivityScreen ({required this.onChoose});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey.shade300,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Bạn đang cảm thấy thế nào?',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: feel(),
      ),
    );
  }

  Widget feel() {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: Colors.orange),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 0, color: Colors.white),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.0),
              hintText: "Tìm kiếm",
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: Colors.grey.shade300,
              ),
            ),
          ),
          Container(
            height: Get.height / 1.3,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 3.2,
              ),
              itemCount: feelCommunity.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black45),
                  ),
                  child: ListTile(
                    onTap: (){
                      onChoose(index);
                      Get.back();
                    },
                    leading: Icon(
                      feelCommunity[index].icon,
                      size: 30,
                    ),
                    title: Text(
                      feelCommunity[index].name.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


}



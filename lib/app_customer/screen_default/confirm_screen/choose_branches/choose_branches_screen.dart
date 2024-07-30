import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/branches.dart';

class ChooseBranchesScreen extends StatelessWidget {
  const ChooseBranchesScreen(
      {super.key, required this.listBranches, required this.onChooose});
  final List<Branches> listBranches;
  final Function onChooose;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn chi nhánh"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...listBranches.map((e) => branch(e))
          ],
        ),
      ),
    );
  }

  Widget branch(Branches branches) {
    return InkWell(
      onTap: (){
        onChooose(branches);
        Get.back();
      },
      child: Container(
        width: Get.width,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(branches.name ?? "",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            if(branches.addressDetail != null)
            Column(
              children: [
                const SizedBox(height: 4,),
                Text("${branches.addressDetail ?? ''} ${branches.wardsName ?? ''} ${branches.districtName ?? ''} ${branches.provinceName ?? ''}")
              ],
            )
          ],
        ),
      ),
    );
  }
}

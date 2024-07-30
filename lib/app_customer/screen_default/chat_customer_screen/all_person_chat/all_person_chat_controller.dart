import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

import '../../../components/toast/saha_alert.dart';
import '../../../remote/response-request/chat/all_person_chat_res.dart';
import '../../../utils/finish_handle_utils.dart';

class AllPersonChatController extends GetxController {

  // SahaDataController sahaDataController = Get.find();

  var listPerson = RxList<PersonChat>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  bool? isNeedHanding;
  var isSearch = false.obs;

  var finish = FinishHandle(milliseconds: 500);

  @override
  void onInit() {
    // refreshWhenRealtime();
    getPersonChat(isRefresh: true);
    super.onInit();
  }

  @override
  void onClose() {
    // SocketUser().close();
    super.onClose();
  }

  // void refreshWhenRealtime() {
  //   timeNow.value = DateTime.now();
  //   sahaDataController.unread.listen((unread) {
  //     if (unread != 0) {
  //       loadInitChatUser();
  //     }
  //   });
  // }

  Future<void> getPersonChat({
    bool? isRefresh,
  }) async {
    finish.run(() async {
      if (isRefresh == true) {
        currentPage = 1;
        isEnd = false;
      }

      try {
        if (isEnd == false) {
          isLoading.value = true;
          var data = await CustomerRepositoryManager.chatCustomerRepository
              .getAllPersonChat(
              search: textSearch,
            currentPage: currentPage,
          );

          if (isRefresh == true) {
            listPerson(data!.data!.data!);
          } else {
            listPerson.addAll(data!.data!.data!);
          }

          if (data.data!.nextPageUrl == null) {
            isEnd = true;
          } else {
            isEnd = false;
            currentPage = currentPage + 1;
          }
        }
        isLoading.value = false;
        loadInit.value = false;
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
    });
  }

}
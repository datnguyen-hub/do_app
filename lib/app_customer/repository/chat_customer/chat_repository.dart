import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../model/message_person_chat.dart';
import '../../remote/customer_service_manager.dart';
import '../../remote/response-request/chat/all_mesage_person_chat_res.dart';
import '../../remote/response-request/chat/all_message_response.dart';
import '../../remote/response-request/chat/all_person_chat_res.dart';
import '../../remote/response-request/chat/message_person_chat_res.dart';
import '../../remote/response-request/chat/send_message_customer_request.dart';
import '../../remote/response-request/chat/send_message_customer_response.dart';

import '../handle_error.dart';

class ChatCustomerRepository {


  Future<MessagePersonChatRes?> sendMessagePersonChat({
  required int customerId,required MessagePersonChat messagePersonChat}) async {
    try {
      var res = await CustomerServiceManager().service!.sendMessagePersonChat(
          StoreInfo().getCustomerStoreCode(),
  customerId,
          messagePersonChat.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllPersonChatRes?> getAllPersonChat({ String? search,
       required int currentPage}) async {
    try {
      var res = await CustomerServiceManager().service!.getAllPersonChat(
          StoreInfo().getCustomerStoreCode(),search, currentPage);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllMesagePersonChatRes?> getMesagePersonChat(
      {required int customerId, required int currentPage}) async {
    try {
      var res = await CustomerServiceManager().service!.getMesagePersonChat(
          StoreInfo().getCustomerStoreCode(),customerId, currentPage);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<AllMessageCustomerResponse?> getAllMessageCustomer(
      int numberPage) async {
    try {
      var res = await CustomerServiceManager().service!.getAllMessageCustomer(
          StoreInfo().getCustomerStoreCode(), numberPage);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }

  Future<SendMessageCustomerResponse?> sendMessageToUser(
      SendMessageCustomerRequest sendMessageCustomerRequest) async {
    try {
      var res = await CustomerServiceManager().service!.sendMessageToUser(
          StoreInfo().getCustomerStoreCode(),
          sendMessageCustomerRequest.toJson());
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
    return null;
  }
}

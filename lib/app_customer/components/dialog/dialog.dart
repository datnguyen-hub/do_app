import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SahaDialogApp {
  static void showDialogOneButton(
      {String? mess, bool barrierDismissible = true, Function? onClose}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thành công!"),
          content: new Text(
              mess == null ? "Gửi yêu cầu bài hát mới thành công!" : mess),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                onClose!();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogNotificationOneButton(
      {String? mess, bool barrierDismissible = true, Function? onClose}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo!"),
          content: new Text(mess == null ? "Chú ý!" : mess),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                onClose!();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showDialogInput(
      {String? title,
      String? hintText,
      Function? onInput,
      Function? onCancel,
      String? textInput,
      TextInputType? textInputType}) {
    return showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) {
          TextEditingController textEditingController =
              new TextEditingController(text: textInput);
          return new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    autofocus: true,
                    keyboardType: textInputType,
                    controller: textEditingController,
                    decoration: new InputDecoration(
                        labelText: title ?? "", hintText: hintText ?? ""),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    if (onCancel != null) onCancel();
                    Navigator.pop(context);
                  }),
              new TextButton(
                  child: const Text('Đồng ý'),
                  onPressed: () {
                    onInput!(textEditingController.text);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  static void showDialogError(
      {required BuildContext context, String? errorMess}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Có lỗi xảy ra"),
          content: new Text(errorMess!),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogYesNo(
      {String? mess,
      bool barrierDismissible = true,
      Function? onClose,
      Function? onOK}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo!"),
          content: new Text(mess == null ? "Chú ý!" : mess),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text(
                "Hủy",
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onClose != null) onClose();
              },
            ),
            new TextButton(
              child: new Text(
                "Đồng ý",
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onOK!();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogAcceptCamera({
    required String title,
    required Function onOK,
    required Function cancle,
  }) {
    // flutter defined function
    showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Yêu cầu",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          contentPadding:
              EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videocam_off_rounded,
                size: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          titlePadding: EdgeInsets.only(bottom: 10, top: 20),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.all(0),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: new Text(
                    "Đồng ý",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  onPressed: () {
                    onOK();
                    Get.back();
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  child: new Text(
                    "Từ chối",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  onPressed: () {
                    cancle();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sahashop_customer/app_customer/load_data/load_firebase.dart';
import 'package:sahashop_customer/app_customer/sahashop_customer.dart';

import 'firebase_options.dart';

const STORE_CODE = "pschanoi";
const STORE_NAME = "PG SÀN THUỐCVIỆT";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    LoadFirebase.initFirebase();
  } catch (e) {
    print(e.toString());
  }
  runApp(SahaShopCustomer(
    storeCode: STORE_CODE,
    storeName: STORE_NAME,
    sloganColor: Colors.black87.withOpacity(0.6),
    slogan: "Sữa Gì Cũng Có",
  ));
}

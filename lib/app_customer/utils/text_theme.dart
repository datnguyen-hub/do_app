import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahashop_customer/app_customer/screen_default/font_data/font_data.dart';

class TextThemeUtil {
  TextTheme textTheme(String font) {
    if (font == DEFAULT_FONT) {
      return GoogleFonts.latoTextTheme();
    } else if (font == BALSAMIQ_REGULAR) {
      return GoogleFonts.balsamiqSansTextTheme();
    } else if (font == LATO_REGULAR) {
      return GoogleFonts.latoTextTheme();
    } else if (font == NEUCHA_REGULAR) {
      return GoogleFonts.neuchaTextTheme();
    } else if (font == NUNITO_REGULAR) {
      return GoogleFonts.nunitoTextTheme();
    } else if (font == VARELA_REGULAR) {
      return GoogleFonts.varelaTextTheme();
    } else {
      return GoogleFonts.latoTextTheme();
    }
  }
}
